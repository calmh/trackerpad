//
//  TrackerClient.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "MREntitiesConverter.h"
#import "PTIteration.h"
#import "PTPerson.h"
#import "PTProject.h"
#import "PTStory.h"
#import "RESTClient.h"
#import "TBXML.h"
#import "TrackerClient.h"

@interface TrackerClient (Private)

- (PTProject*)projectInProjectElement:(TBXMLElement*)projectElement;
- (NSArray*)membersInProjectElement:(TBXMLElement*)projectElement;
- (PTPerson*)personInMembershipElement:(TBXMLElement*)membershipElement;
- (NSArray*)iterationsInXML:(TBXML*)xml;
- (PTIteration*)iterationInIterationElement:(TBXMLElement*)iterationElement;
- (NSArray*)storiesInIterationElement:(TBXMLElement*)iterationElement;
- (NSArray*)storiesInStoriesElement:(TBXMLElement*)storiesElement;
- (PTStory*)storyInStoryElement:(TBXMLElement*)storyElement;
- (NSURL*)urlForPath:(NSString*)path;
- (TBXML*)xmlForURLString:(NSString*)url;
- (TBXML*)xmlForURLString:(NSString*)urlString andParameters:(NSDictionary*)parameters;
- (TBXML*)xmlForURLString:(NSString*)url withUsername:(NSString*)username andPassword:(NSString*)password;
- (TBXML*)xmlForURLString:(NSString*)urlString usingVerb:(NSString*)verb withParameters:(NSDictionary*)parameters andHeaders:(NSDictionary*)headers;

@end

@implementation TrackerClient

@synthesize token;

- (void)dealloc
{
        self.token = nil;
        [converter release];
        [tbxml release];
        [super dealloc];
}

- (id)init
{
        if (self = [super init]) {
                tbxml = nil;
                converter = [[MREntitiesConverter alloc] init];
        }
        return self;
}

- (id)initWithTBXML:(TBXML*)theTbxml
{
        if (self = [super init]) {
                tbxml = [theTbxml retain];
                converter = [[MREntitiesConverter alloc] init];
        }
        return self;
}

- (id)initWithToken:(NSString*)theToken
{
        if (self = [super init]) {
                self.token = theToken;
                converter = [[MREntitiesConverter alloc] init];
        }
        return self;
}

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
                PTProject *project = [self projectInProjectElement:projectElement];
                [projects addObject:project];
                projectElement = [TBXML nextSiblingNamed:@"project" searchFromElement:projectElement];
        }

        return [projects autorelease];
}

- (PTIteration*)currentIterationInProject:(NSUInteger)projectId
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

- (PTIteration*)iceboxIterationInProject:(NSUInteger)projectId
{
        TBXML *xml = [self xmlForURLString:[NSString stringWithFormat:@"projects/%d/stories", projectId]
                             andParameters:[NSDictionary dictionaryWithObjectsAndKeys:@"state:unscheduled", @"filter", nil]];
        NSArray *stories = [self storiesInStoriesElement:xml.rootXMLElement];

        PTIteration *iteration = [[PTIteration alloc] init];
        iteration.id = 0;
        iteration.number = 0;
        iteration.start = [NSDate date];
        iteration.finish = [NSDate date];
        [iteration addStoriesFromArray:stories];
        return iteration;
}

// Private methods below

- (PTProject*)projectInProjectElement:(TBXMLElement*)projectElement
{
        assert(projectElement != nil);
        PTProject *project = [[PTProject alloc] init];

        project.name = [converter convertEntiesInString:[TBXML textForElement:[TBXML childElementNamed:@"name" parentElement:projectElement]]];
        project.id = [[TBXML textForElement:[TBXML childElementNamed:@"id" parentElement:projectElement]] intValue];
        project.velocity = [[TBXML textForElement:[TBXML childElementNamed:@"current_velocity" parentElement:projectElement]] intValue];
        project.members = [self membersInProjectElement:projectElement];

        return [project autorelease];
}

- (NSArray*)membersInProjectElement:(TBXMLElement*)projectElement
{
        assert(projectElement != nil);
        NSMutableArray *members = [[NSMutableArray alloc] init];

        TBXMLElement *membershipsElement = [TBXML childElementNamed:@"memberships" parentElement:projectElement];
        TBXMLElement *membershipElement = [TBXML childElementNamed:@"membership" parentElement:membershipsElement];
        while (membershipElement != nil) {
                PTPerson *person = [self personInMembershipElement:membershipElement];
                [members addObject:person];
                membershipElement = [TBXML nextSiblingNamed:@"membership" searchFromElement:membershipElement];
        }

        return [members autorelease];
}

- (PTPerson*)personInMembershipElement:(TBXMLElement*)membershipElement
{
        assert(membershipElement != nil);
        PTPerson *person = [[PTPerson alloc] init];

        TBXMLElement *idElement = [TBXML childElementNamed:@"id" parentElement:membershipElement];
        person.id = [[TBXML textForElement:idElement] intValue];
        TBXMLElement *personElement = [TBXML childElementNamed:@"person" parentElement:membershipElement];
        person.name = [converter convertEntiesInString:[TBXML textForElement:[TBXML childElementNamed:@"name" parentElement:personElement]]];
        person.email = [converter convertEntiesInString:[TBXML textForElement:[TBXML childElementNamed:@"email" parentElement:personElement]]];
        person.initials = [converter convertEntiesInString:[TBXML textForElement:[TBXML childElementNamed:@"initials" parentElement:personElement]]];
        person.role = [converter convertEntiesInString:[TBXML textForElement:[TBXML childElementNamed:@"role" parentElement:membershipElement]]];

        return [person autorelease];
}

- (NSArray*)iterationsInXML:(TBXML*)xml
{
        assert(xml != nil);
        TBXMLElement *rootElement = xml.rootXMLElement;
        assert(rootElement != nil);

        NSMutableArray *iterations = [[NSMutableArray alloc] init];
        TBXMLElement *iterationElement = [TBXML childElementNamed:@"iteration" parentElement:rootElement];
        while (iterationElement != nil) {
                PTIteration *iteration = [self iterationInIterationElement:iterationElement];
                [iterations addObject:iteration];
                iterationElement = [TBXML nextSiblingNamed:@"iteration" searchFromElement:iterationElement];
        }

        return [iterations autorelease];
}

- (PTIteration*)iterationInIterationElement:(TBXMLElement*)iterationElement
{
        static NSDateFormatter *dateFormatter = nil;
        if (dateFormatter == nil) {
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
                [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
        }

        assert(iterationElement != nil);
        PTIteration *iteration = [[PTIteration alloc] init];

        iteration.id = [[TBXML textForElement:[TBXML childElementNamed:@"id" parentElement:iterationElement]] intValue];
        iteration.number = [[TBXML textForElement:[TBXML childElementNamed:@"number" parentElement:iterationElement]] intValue];
        iteration.start = [dateFormatter dateFromString:[TBXML textForElement:[TBXML childElementNamed:@"start" parentElement:iterationElement]]];
        iteration.finish = [dateFormatter dateFromString:[TBXML textForElement:[TBXML childElementNamed:@"finish" parentElement:iterationElement]]];

        NSArray *stories = [self storiesInIterationElement:iterationElement];
        [iteration addStoriesFromArray:stories];

        return [iteration autorelease];
}

- (NSArray*)storiesInIterationElement:(TBXMLElement*)iterationElement
{
        assert(iterationElement != nil);
        TBXMLElement *storiesElement = [TBXML childElementNamed:@"stories" parentElement:iterationElement];
        return [self storiesInStoriesElement:storiesElement];
}

- (NSArray*)storiesInStoriesElement:(TBXMLElement*)storiesElement
{
        assert(storiesElement != nil);
        NSMutableArray *stories = [[NSMutableArray alloc] init];
        TBXMLElement *storyElement = [TBXML childElementNamed:@"story" parentElement:storiesElement];
        while (storyElement != nil) {
                PTStory *story = [self storyInStoryElement:storyElement];
                [stories addObject:story];
                storyElement = [TBXML nextSiblingNamed:@"story" searchFromElement:storyElement];
        }
        return [stories autorelease];
}

- (PTStory*)storyInStoryElement:(TBXMLElement*)storyElement
{
        assert(storyElement != nil);
        PTStory *story = [[PTStory alloc] init];

        story.name = [converter convertEntiesInString:[TBXML textForElement:[TBXML childElementNamed:@"name" parentElement:storyElement]]];
        story.description = [converter convertEntiesInString:[TBXML textForElement:[TBXML childElementNamed:@"description" parentElement:storyElement]]];
        story.type = [TBXML textForElement:[TBXML childElementNamed:@"story_type" parentElement:storyElement]];
        story.state = [TBXML textForElement:[TBXML childElementNamed:@"current_state" parentElement:storyElement]];
        story.id = [[TBXML textForElement:[TBXML childElementNamed:@"id" parentElement:storyElement]] intValue];
        story.owner = [converter convertEntiesInString:[TBXML textForElement:[TBXML childElementNamed:@"owned_by" parentElement:storyElement]]];

        TBXMLElement *estimateElement = [TBXML childElementNamed:@"estimate" parentElement:storyElement];
        if (estimateElement != nil)
                story.estimate = [[TBXML textForElement:estimateElement] intValue];

        return [story autorelease];
}

- (NSURL*)urlForPath:(NSString*)path
{
        assert(path != nil);
        return [NSURL URLWithString:[NSString stringWithFormat:@"https://www.pivotaltracker.com/services/v3/%@", path]];
}

- (TBXML*)xmlForURLString:(NSString*)urlString
{
        assert(urlString != nil);
        return [self xmlForURLString:urlString andParameters:nil];
}

- (TBXML*)xmlForURLString:(NSString*)urlString andParameters:(NSDictionary*)parameters
{
        if (tbxml != nil)
                return tbxml;

        assert(urlString != nil);

        return [self xmlForURLString:urlString
                           usingVerb:@"GET"
                      withParameters:parameters
                          andHeaders:[NSDictionary dictionaryWithObjectsAndKeys:self.token, @"X-TrackerToken", nil]];
}

- (TBXML*)xmlForURLString:(NSString*)urlString withUsername:(NSString*)username andPassword:(NSString*)password
{
        if (tbxml != nil)
                return tbxml;

        assert(urlString != nil);
        assert(username != nil);
        assert(password != nil);

        return [self xmlForURLString:urlString
                           usingVerb:@"POST"
                      withParameters:[NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil]
                          andHeaders:nil];
}

- (TBXML*)xmlForURLString:(NSString*)urlString usingVerb:(NSString*)verb withParameters:(NSDictionary*)parameters andHeaders:(NSDictionary*)headers
{
        assert(urlString != nil);
        assert(verb != nil);

        NSURL *url = [self urlForPath:urlString];
        RESTClient *client = [[RESTClient alloc] init];
        client.asynchronous = NO;
        [client sendRequestTo:url
                    usingVerb:verb
               withParameters:parameters
                   andHeaders:headers];
        TBXML *currentTbxml = [[TBXML tbxmlWithXMLData:client.receivedData] retain];
        [client release];
        return currentTbxml;
}

@end
