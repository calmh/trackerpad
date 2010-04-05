//
//  TrackerClient.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MREntitiesConverter;
@class PTIteration;
@class TBXML;

@interface TrackerClient : NSObject {
        TBXML *tbxml;
        MREntitiesConverter *converter;
        NSString *token;
}

@property (retain, nonatomic) NSString *token;

- (void)dealloc;
- (id)initWithTBXML:(TBXML*)theTbxml;
- (id)initWithToken:(NSString*)token;
- (NSString*)getTokenForUsername:(NSString*)username andPassword:(NSString*)password;
- (NSArray*)projects;
- (PTIteration*)currentIterationInProject:(NSUInteger)projectId;
- (NSArray*)doneIterationsInProject:(NSUInteger)projectId;
- (NSArray*)backlogIterationsInProject:(NSUInteger)projectId;
- (PTIteration*)iceboxIterationInProject:(NSUInteger)projectId;

@end
