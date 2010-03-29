//
//  TrackerIteration.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TrackerIteration : NSObject {
        NSMutableArray *stories;
        uint32_t id;
        uint32_t number;
        NSDate *start;
        NSDate *finish;
}

@property (readonly) NSMutableArray *stories;
@property (assign) uint32_t id;
@property (assign) uint32_t number;
@property (retain, nonatomic) NSDate *start;
@property (retain, nonatomic) NSDate *finish;

- (void)addStoriesFromArray:(NSArray*)moreStories;

@end
