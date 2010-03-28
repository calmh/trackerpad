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

- (void)testGetCurrentStoryList
{
        NSString *filename = [NSString stringWithFormat:@"%@/iterations-current.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *storyList = [tracker getCurrentStories];
        
        STAssertEquals([storyList count], 4u, nil);
        
        [tracker release];
}

@end
