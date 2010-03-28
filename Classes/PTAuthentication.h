//
//  PTAuthentication.h
//  NNPivotalTracker
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLReader.h"

@interface PTAuthentication : XMLReader {
}

- (NSString*) getTokenForUsername:(NSString*)username andPassword:(NSString*)password;

@end
