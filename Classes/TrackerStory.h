//
//  TrackerStory.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackerStory : NSObject {
        NSUInteger id;
        NSUInteger project_id;
        NSInteger estimate;
        NSString *name;
        NSString *description;
        NSString *state; // TODO: Change this to an enum
        NSString *type; // TODO: Change this to an enum
}

@property (assign, nonatomic) NSUInteger id;
@property (assign, nonatomic) NSUInteger project_id;
@property (assign, nonatomic) NSInteger estimate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *description;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *type;

@end
