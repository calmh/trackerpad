//
//  PTProjects.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTBaseCommunication.h"

@interface PTProjects : PTBaseCommunication {

}

- (NSArray*) getProjectListWithToken:(NSString*)token;

@end
