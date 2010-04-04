//
//  PTStory.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTStory : NSObject {
        NSUInteger id;
        NSUInteger projectId;
        NSInteger estimate;
        NSString *name;
        NSString *description;
        NSString *state; // TODO: Change this to an enum
        NSString *type; // TODO: Change this to an enum
        NSString *owner;
}

@property (assign, nonatomic) NSUInteger id;
@property (assign, nonatomic) NSUInteger projectId;
@property (assign, nonatomic) NSInteger estimate;
@property (retain, nonatomic) NSString *name;
@property (retain, nonatomic) NSString *description;
@property (retain, nonatomic) NSString *state;
@property (retain, nonatomic) NSString *type;
@property (retain, nonatomic) NSString *owner;

@end
