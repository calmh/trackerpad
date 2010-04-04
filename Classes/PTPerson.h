//
//  PTPerson.h
//  TrackerPad
//
//  Created by Jakob Borg on 4/4/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTPerson : NSObject {
        NSUInteger id;
        NSString *name;
        NSString *email;
        NSString *initials;
        NSString *role; // TODO: Make enum instead
}

@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *initials;
@property (nonatomic, retain) NSString *role;

@end
