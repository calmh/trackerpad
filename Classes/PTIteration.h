//
//  PTIteration.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTIteration : NSObject {
        NSMutableArray *stories;
        NSUInteger id;
        NSUInteger number;
        NSDate *start;
        NSDate *finish;
}

@property (readonly) NSMutableArray *stories;
@property (assign) NSUInteger id;
@property (assign) NSUInteger number;
@property (retain, nonatomic) NSDate *start;
@property (retain, nonatomic) NSDate *finish;

- (void)addStoriesFromArray:(NSArray*)moreStories;

@end
