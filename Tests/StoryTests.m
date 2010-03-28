//
//  StoryTests.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "StoryTests.h"
#import "Tracker.h"
#import "TrackerStory.h"

@implementation StoryTests

- (void)testCurrentStoriesShouldBeFour
{
        NSString *filename = [NSString stringWithFormat:@"%@/iterations-current.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *stories = [tracker currentStories];

        STAssertEquals([stories count], 4u, nil);

        [tracker release];
}

- (void)testFirstOfCurrentStoriesValues
{
        NSString *filename = [NSString stringWithFormat:@"%@/iterations-current.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *stories = [tracker currentStories];

        TrackerStory *story = [stories objectAtIndex:0];
        STAssertEquals(story.id, 2958790u, nil);
        STAssertEqualObjects(story.type, @"feature", nil);
        STAssertEquals(story.estimate, 3u, nil);
        STAssertEqualObjects(story.state, @"accepted", nil);
        STAssertEqualObjects(story.name, @"Story 1", nil);
        STAssertEqualObjects(story.description, @"This is a first story", nil);

        [tracker release];
}

@end
