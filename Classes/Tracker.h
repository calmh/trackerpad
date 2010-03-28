//
//  Tracker.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "TBXML.h"
#import <Foundation/Foundation.h>

@interface Tracker : NSObject {
        TBXML *tbxml;
}

- (void)dealloc;
- (id)initWithTBXML:(TBXML*)theTbxml;
- (NSString*)getTokenForUsername:(NSString*)username andPassword:(NSString*)password;
- (NSArray*)getProjectListWithToken:(NSString*)token;

@end
