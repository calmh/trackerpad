//
//  Wrapper.h
//  WrapperTest
//
//  Created by Adrian on 10/18/08.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "RESTClientDelegate.h"
#import <Foundation/Foundation.h>

@interface RESTClient : NSObject
{
        @private
        NSMutableData *receivedData;
        NSString *mimeType;
        NSURLConnection *conn;
        BOOL asynchronous;
        NSObject<RESTClientDelegate> *delegate;
        NSString *username;
        NSString *password;
}

@property (nonatomic, readonly) NSData *receivedData;
@property (nonatomic) BOOL asynchronous;
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, assign) NSObject<RESTClientDelegate> *delegate; // Do not retain delegates!

- (void)sendRequestTo:(NSURL*)url usingVerb:(NSString*)verb withParameters:(NSDictionary*)parameters andHeaders:(NSDictionary*)headers;
- (void)uploadData:(NSData*)data toURL:(NSURL*)url;
- (void)cancelConnection;
- (NSDictionary*)responseAsPropertyList;
- (NSString*)responseAsText;

@end
