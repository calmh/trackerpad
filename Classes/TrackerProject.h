//
//  TrackerProject.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "TrackerPerson.h"
#import <Foundation/Foundation.h>

@interface TrackerProject : NSObject {
        NSUInteger id;
        NSInteger velocity;
        NSString *name;
        NSArray *members;
}

@property (retain, nonatomic) NSString *name;
@property (assign, nonatomic) NSUInteger id;
@property (assign, nonatomic) NSInteger velocity;
@property (retain, nonatomic) NSArray *members;

- (TrackerPerson*)memberNamed:(NSString*)fullName;

@end
