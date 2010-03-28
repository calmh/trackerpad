//
//  PTBaseCommunication.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"

@interface PTBaseCommunication : NSObject {
	TBXML *tbxml;
}

- (void) dealloc;
- (id) initWithTBXML:(TBXML*)theTbxml;
- (TBXML*) xmlForURLString:(NSString*)url withUsername:(NSString*)username andPassword:(NSString*)password;
- (TBXML*) xmlForURLString:(NSString*)url withToken:(NSString*)token;
- (NSURL*) urlForPath:(NSString*)path;

@end
