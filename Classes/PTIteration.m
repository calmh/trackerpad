//
//  PTIteration.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "PTIteration.h"

@implementation PTIteration

@synthesize stories;
@synthesize id;
@synthesize number;
@synthesize start;
@synthesize finish;

- (id)init
{
        if (self = [super init])
                stories = [[NSMutableArray alloc] init];
        return self;
}

- (void)addStoriesFromArray:(NSArray*)moreStories
{
        [stories addObjectsFromArray:moreStories];
}

@end
