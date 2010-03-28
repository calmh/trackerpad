//
//  Tracker.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "RESTClient.h"
#import "Tracker.h"
#import "TrackerProject.h"
#import "TrackerStory.h"

@interface Tracker (Private)

- (NSArray*)storiesInIterations:(TBXML*)xml;
- (TBXML*)xmlForURLString:(NSString*)url withUsername:(NSString*)username andPassword:(NSString*)password;
- (TBXML*)xmlForURLString:(NSString*)url;
- (NSURL*)urlForPath:(NSString*)path;

@end

@implementation Tracker

@synthesize token;

- (void)dealloc
{
        self.token = nil;
        [tbxml release];
        [super dealloc];
}

- (id)init
{
        if (self = [super init])
                tbxml = nil;
        return self;
}

- (id)initWithTBXML:(TBXML*)theTbxml
{
        if (self = [super init])
                tbxml = [theTbxml retain];
        return self;
}

- (id)initWithToken:(NSString*)theToken
{
        if (self = [super init])
                self.token = theToken;
        return self;
}

#pragma mark Public functions

- (NSString*)getTokenForUsername:(NSString*)username andPassword:(NSString*)password
{
        TBXML *xml = [self xmlForURLString:@"tokens/active" withUsername:username andPassword:password];

        TBXMLElement *rootElement = xml.rootXMLElement;
        assert(rootElement != nil);

        TBXMLElement *guidElement = [TBXML childElementNamed:@"guid" parentElement:rootElement];
        assert(guidElement != nil);

        return [TBXML textForElement:guidElement];
}

- (NSArray*)projects
{
        TBXML *xml = [self xmlForURLString:@"projects"];

        TBXMLElement *rootElement = xml.rootXMLElement;
        assert(rootElement != nil);

        NSMutableArray *projects = [[NSMutableArray alloc] init];

        TBXMLElement *projectElement = [TBXML childElementNamed:@"project" parentElement:rootElement];
        while (projectElement != nil) {
                TrackerProject *project = [[TrackerProject alloc] init];

                project.name = [TBXML textForElement:[TBXML childElementNamed:@"name" parentElement:projectElement]];
                project.id = [[TBXML textForElement:[TBXML childElementNamed:@"id" parentElement:projectElement]] intValue];
                project.velocity = [[TBXML textForElement:[TBXML childElementNamed:@"current_velocity" parentElement:projectElement]] intValue];

                [projects addObject:project];
                [project release];

                projectElement = [TBXML nextSiblingNamed:@"project" searchFromElement:projectElement];
        }

        return [projects autorelease];
}

- (NSArray*)currentStoriesInProject:(uint32_t)project_id
{
        TBXML *xml = [self xmlForURLString:[NSString stringWithFormat:@"projects/%d/iterations/current", project_id]];
        return [self storiesInIterations:xml];
}

- (NSArray*)doneStoriesInProject:(uint32_t)project_id
{
        TBXML *xml = [self xmlForURLString:[NSString stringWithFormat:@"projects/%d/iterations/done", project_id]];
        return [self storiesInIterations:xml];
}

- (NSArray*)backlogStoriesInProject:(uint32_t)project_id
{
        TBXML *xml = [self xmlForURLString:[NSString stringWithFormat:@"projects/%d/iterations/backlog", project_id]];
        return [self storiesInIterations:xml];
}

#pragma mark Private functions

- (NSArray*)storiesInIterations:(TBXML*)xml
{
        TBXMLElement *rootElement = xml.rootXMLElement;
        assert(rootElement != nil);

        NSMutableArray *stories = [[NSMutableArray alloc] init];

        TBXMLElement *iterationElement = [TBXML childElementNamed:@"iteration" parentElement:rootElement];
        while (iterationElement != nil) {
                TBXMLElement *storiesElement = [TBXML childElementNamed:@"stories" parentElement:iterationElement];

                TBXMLElement *storyElement = [TBXML childElementNamed:@"story" parentElement:storiesElement];
                while (storyElement != nil) {
                        TrackerStory *story = [[TrackerStory alloc] init];

                        story.name = [TBXML textForElement:[TBXML childElementNamed:@"name" parentElement:storyElement]];
                        story.description = [TBXML textForElement:[TBXML childElementNamed:@"description" parentElement:storyElement]];
                        story.type = [TBXML textForElement:[TBXML childElementNamed:@"story_type" parentElement:storyElement]];
                        story.state = [TBXML textForElement:[TBXML childElementNamed:@"current_state" parentElement:storyElement]];
                        story.id = [[TBXML textForElement:[TBXML childElementNamed:@"id" parentElement:storyElement]] intValue];
                        TBXMLElement *estimateElement = [TBXML childElementNamed:@"estimate" parentElement:storyElement];
                        if (estimateElement != nil)
                                story.estimate = [[TBXML textForElement:estimateElement] intValue];

                        [stories addObject:story];
                        [story release];

                        storyElement = [TBXML nextSiblingNamed:@"story" searchFromElement:storyElement];
                }

                iterationElement = [TBXML nextSiblingNamed:@"project" searchFromElement:iterationElement];
        }

        return [stories autorelease];
}

- (TBXML*)xmlForURLString:(NSString*)urlString withUsername:(NSString*)username andPassword:(NSString*)password
{
        if (tbxml == nil) {
                NSURL *url = [self urlForPath:urlString];
                RESTClient *client = [[RESTClient alloc] init];
                client.asynchronous = NO;
                [client sendRequestTo:url usingVerb:@"POST" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil] andHeaders:nil];
                tbxml = [[TBXML tbxmlWithXMLData:client.receivedData] retain];
                [client release];
        }

        return tbxml;
}

- (TBXML*)xmlForURLString:(NSString*)urlString
{
        if (tbxml == nil) {
                NSURL *url = [self urlForPath:urlString];
                RESTClient *client = [[RESTClient alloc] init];
                client.asynchronous = NO;
                [client sendRequestTo:url
                            usingVerb:@"GET"
                       withParameters:nil
                           andHeaders:[NSDictionary dictionaryWithObjectsAndKeys:self.token, @"X-TrackerToken", nil]];
                tbxml = [[TBXML tbxmlWithXMLData:client.receivedData] retain];
                [client release];
        }

        return tbxml;
}

- (NSURL*)urlForPath:(NSString*)path
{
        return [NSURL URLWithString:[NSString stringWithFormat:@"https://www.pivotaltracker.com/services/v3/%@", path]];
}

@end
