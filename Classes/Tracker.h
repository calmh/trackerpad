//
//  Tracker.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "TBXML.h"
#import "TrackerIteration.h"
#import <Foundation/Foundation.h>

@interface Tracker : NSObject {
        TBXML *tbxml;
        NSString *token;
}

@property (retain, nonatomic) NSString *token;

- (void)dealloc;
- (id)initWithTBXML:(TBXML*)theTbxml;
- (id)initWithToken:(NSString*)token;
- (NSString*)getTokenForUsername:(NSString*)username andPassword:(NSString*)password;
- (NSArray*)projects;
- (TrackerIteration*)currentIterationInProject:(uint32_t)project_id;
- (NSArray*)doneIterationsInProject:(uint32_t)project_id;
- (NSArray*)backlogIterationsInProject:(uint32_t)project_id;

@end
