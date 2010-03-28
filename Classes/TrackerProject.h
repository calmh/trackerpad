//
//  TrackerProject.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrackerProject : NSObject {
        uint32_t id;
        uint32_t velocity;
        NSString *name;
}

@property (retain, nonatomic) NSString *name;
@property (assign, nonatomic) uint32_t id;
@property (assign, nonatomic) uint32_t velocity;

@end
