//
//  Tracker.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "RESTClient.h"
#import "Tracker.h"
#import "TrackerIteration.h"
#import "TrackerPerson.h"
#import "TrackerProject.h"
#import "TrackerStory.h"

@interface Tracker (Private)

- (NSArray*)iterationsInXML:(TBXML*)xml;
- (NSArray*)storiesInIterationElement:(TBXMLElement*)iterationElement;
- (NSArray*)storiesInStoriesElement:(TBXMLElement*)storiesElement;
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

                NSMutableArray *members = [[NSMutableArray alloc] init];
                TBXMLElement *membershipsElement = [TBXML childElementNamed:@"memberships" parentElement:projectElement];
                TBXMLElement *membershipElement = [TBXML childElementNamed:@"membership" parentElement:membershipsElement];
                while (membershipElement != nil) {
                        TrackerPerson *person = [[TrackerPerson alloc] init];

                        TBXMLElement *idElement = [TBXML childElementNamed:@"id" parentElement:membershipElement];
                        person.id = [[TBXML textForElement:idElement] intValue];
                        TBXMLElement *personElement = [TBXML childElementNamed:@"person" parentElement:membershipElement];
                        person.name = [TBXML textForElement:[TBXML childElementNamed:@"name" parentElement:personElement]];
                        person.email = [TBXML textForElement:[TBXML childElementNamed:@"email" parentElement:personElement]];
                        person.initials = [TBXML textForElement:[TBXML childElementNamed:@"initials" parentElement:personElement]];
                        person.role = [TBXML textForElement:[TBXML childElementNamed:@"role" parentElement:membershipElement]];

                        [members addObject:person];
                        membershipElement = [TBXML nextSiblingNamed:@"membership" searchFromElement:membershipElement];
                }
                project.members = members;
                [members release];

                [projects addObject:project];
                [project release];

                projectElement = [TBXML nextSiblingNamed:@"project" searchFromElement:projectElement];
        }

        return [projects autorelease];
}

- (TrackerIteration*)currentIterationInProject:(NSUInteger)projectId
{
        TBXML *xml = [self xmlForURLString:[NSString stringWithFormat:@"projects/%d/iterations/current", projectId]];
        return [[self iterationsInXML:xml] objectAtIndex:0];
}

- (NSArray*)doneIterationsInProject:(NSUInteger)projectId
{
        TBXML *xml = [self xmlForURLString:[NSString stringWithFormat:@"projects/%d/iterations/done", projectId]];
        return [self iterationsInXML:xml];
}

- (NSArray*)backlogIterationsInProject:(NSUInteger)projectId
{
        TBXML *xml = [self xmlForURLString:[NSString stringWithFormat:@"projects/%d/iterations/backlog", projectId]];
        return [self iterationsInXML:xml];
}

- (TrackerIteration*)iceboxIterationInProject:(NSUInteger)projectId
{
        TBXML *xml = [self xmlForURLString:[NSString stringWithFormat:@"projects/%d/stories?state=unscheduled", projectId]];
        NSArray *stories = [self storiesInStoriesElement:xml.rootXMLElement];

        TrackerIteration *iteration = [[TrackerIteration alloc] init];
        iteration.id = 0;
        iteration.number = 0;
        iteration.start = [NSDate date];
        iteration.finish = [NSDate date];
        iteration.stories = stories;
        return iteration;
}

#pragma mark Private functions

- (NSArray*)iterationsInXML:(TBXML*)xml
{
        TBXMLElement *rootElement = xml.rootXMLElement;
        assert(rootElement != nil);

        NSMutableArray *iterations = [[NSMutableArray alloc] init];

        TBXMLElement *iterationElement = [TBXML childElementNamed:@"iteration" parentElement:rootElement];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        while (iterationElement != nil) {
                TrackerIteration *iteration = [[TrackerIteration alloc] init];

                iteration.id = [[TBXML textForElement:[TBXML childElementNamed:@"id" parentElement:iterationElement]] intValue];
                iteration.number = [[TBXML textForElement:[TBXML childElementNamed:@"number" parentElement:iterationElement]] intValue];
                iteration.start = [dateFormatter dateFromString:[TBXML textForElement:[TBXML childElementNamed:@"start" parentElement:iterationElement]]];
                iteration.finish = [dateFormatter dateFromString:[TBXML textForElement:[TBXML childElementNamed:@"finish" parentElement:iterationElement]]];

                NSArray *stories = [self storiesInIterationElement:iterationElement];
                [iteration addStoriesFromArray:stories];
                [iterations addObject:iteration];
                [iteration release];
                iterationElement = [TBXML nextSiblingNamed:@"iteration" searchFromElement:iterationElement];
        }
        [dateFormatter release];

        return [iterations autorelease];
}

- (NSArray*)storiesInIterationElement:(TBXMLElement*)iterationElement
{
        TBXMLElement *storiesElement = [TBXML childElementNamed:@"stories" parentElement:iterationElement];
        return [self storiesInStoriesElement:storiesElement];
}

- (NSArray*)storiesInStoriesElement:(TBXMLElement*)storiesElement
{
        NSMutableArray *stories = [[NSMutableArray alloc] init];
        TBXMLElement *storyElement = [TBXML childElementNamed:@"story" parentElement:storiesElement];
        while (storyElement != nil) {
                TrackerStory *story = [[TrackerStory alloc] init];

                story.name = [[TBXML textForElement:[TBXML childElementNamed:@"name" parentElement:storyElement]] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                story.description = [TBXML textForElement:[TBXML childElementNamed:@"description" parentElement:storyElement]];
                story.type = [TBXML textForElement:[TBXML childElementNamed:@"story_type" parentElement:storyElement]];
                story.state = [TBXML textForElement:[TBXML childElementNamed:@"current_state" parentElement:storyElement]];
                story.id = [[TBXML textForElement:[TBXML childElementNamed:@"id" parentElement:storyElement]] intValue];
                story.owner = [TBXML textForElement:[TBXML childElementNamed:@"owned_by" parentElement:storyElement]];
                TBXMLElement *estimateElement = [TBXML childElementNamed:@"estimate" parentElement:storyElement];
                if (estimateElement != nil)
                        story.estimate = [[TBXML textForElement:estimateElement] intValue];

                [stories addObject:story];
                [story release];

                storyElement = [TBXML nextSiblingNamed:@"story" searchFromElement:storyElement];
        }
        return [stories autorelease];
}

- (TBXML*)xmlForURLString:(NSString*)urlString withUsername:(NSString*)username andPassword:(NSString*)password
{
        if (tbxml != nil)
                return tbxml;

        NSURL *url = [self urlForPath:urlString];
        RESTClient *client = [[RESTClient alloc] init];
        client.asynchronous = NO;
        [client sendRequestTo:url usingVerb:@"POST" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil] andHeaders:nil];
        TBXML *currentTbxml = [[TBXML tbxmlWithXMLData:client.receivedData] retain];
        [client release];
        return currentTbxml;
}

- (TBXML*)xmlForURLString:(NSString*)urlString
{
        if (tbxml != nil)
                return tbxml;

        NSURL *url = [self urlForPath:urlString];
        RESTClient *client = [[RESTClient alloc] init];
        client.asynchronous = NO;
        [client sendRequestTo:url
                    usingVerb:@"GET"
               withParameters:nil
                   andHeaders:[NSDictionary dictionaryWithObjectsAndKeys:self.token, @"X-TrackerToken", nil]];
        TBXML *currentTbxml = [[TBXML tbxmlWithXMLData:client.receivedData] retain];
        [client release];
        return currentTbxml;
}

- (NSURL*)urlForPath:(NSString*)path
{
        return [NSURL URLWithString:[NSString stringWithFormat:@"https://www.pivotaltracker.com/services/v3/%@", path]];
}

@end
