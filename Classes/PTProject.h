//
//  PTProject.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PTPerson;

@interface PTProject : NSObject {
        NSUInteger id;
        NSInteger velocity;
        NSString *name;
        NSArray *members;
}

@property (retain, nonatomic) NSString *name;
@property (assign, nonatomic) NSUInteger id;
@property (assign, nonatomic) NSInteger velocity;
@property (retain, nonatomic) NSArray *members;

- (PTPerson*)memberNamed:(NSString*)fullName;

@end
