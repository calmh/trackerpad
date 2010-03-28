//
//  TrackerStory.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackerStory : NSObject {
        uint32_t id;
        uint32_t project_id;
        uint32_t estimate;
        NSString *name;
        NSString *description;
        NSString *state; // TODO: Change this to an enum
        NSString *type; // TODO: Change this to an enum
}

@property (assign, nonatomic) uint32_t id;
@property (assign, nonatomic) uint32_t project_id;
@property (assign, nonatomic) uint32_t estimate;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *description;
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *type;

@end
