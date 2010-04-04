//
//  StoryTests.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "StoryTests.h"
#import "Tracker.h"
#import "TrackerIteration.h"
#import "TrackerStory.h"

@implementation StoryTests

- (void)testAllIterationsShouldBeTwo
{
        NSString *filename = [NSString stringWithFormat:@"%@/iterations.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *iterations = [tracker backlogIterationsInProject:0];

        STAssertEquals([iterations count], 2u, nil);

        [tracker release];
}

- (void)testCurrentIterationValues
{
        NSString *filename = [NSString stringWithFormat:@"%@/iterations-current.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        TrackerIteration *iteration = [tracker currentIterationInProject:0];

        STAssertEquals(iteration.number, 1u, nil);
        STAssertEquals(iteration.id, 1u, nil);
        STAssertEqualObjects(iteration.start, [NSDate dateWithTimeIntervalSince1970:1269241200u], nil);
        STAssertEqualObjects(iteration.finish, [NSDate dateWithTimeIntervalSince1970:1269846000u], nil);

        [tracker release];
}

- (void)testCurrentStoriesShouldBeFour
{
        NSString *filename = [NSString stringWithFormat:@"%@/iterations-current.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        TrackerIteration *iteration = [tracker currentIterationInProject:0];
        NSArray *stories = iteration.stories;

        STAssertEquals([stories count], 4u, nil);

        [tracker release];
}

- (void)testBacklogStoriesShouldBeThree
{
        NSString *filename = [NSString stringWithFormat:@"%@/iterations-backlog.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *iterations = [tracker backlogIterationsInProject:0];
        NSArray *stories = ((TrackerIteration*)[iterations objectAtIndex:0]).stories;

        STAssertEquals([stories count], 3u, nil);

        [tracker release];
}

- (void)testIceboxStoriesShouldBeNine
{
        NSString *filename = [NSString stringWithFormat:@"%@/icebox.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        TrackerIteration *iteration = [tracker iceboxIterationInProject:0];
        NSArray *stories = iteration.stories;

        STAssertEquals([stories count], 9u, nil);

        [tracker release];
}

- (void)testFirstOfCurrentStoriesValues
{
        NSString *filename = [NSString stringWithFormat:@"%@/iterations-current.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        TrackerIteration *iteration = [tracker currentIterationInProject:0];
        NSArray *stories = iteration.stories;

        TrackerStory *story = [stories objectAtIndex:0];
        STAssertEquals(story.id, 2958790u, nil);
        STAssertEqualObjects(story.type, @"feature", nil);
        STAssertEquals(story.estimate, 3, nil);
        STAssertEqualObjects(story.state, @"accepted", nil);
        STAssertEqualObjects(story.name, @"Story 1", nil);
        STAssertEqualObjects(story.description, @"This is a first story", nil);
        STAssertEqualObjects(story.owner, @"Test Testsson", nil);

        [tracker release];
}

@end
