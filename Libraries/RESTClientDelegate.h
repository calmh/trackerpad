//
//  WrapperDelegate.h
//  WrapperTest
//
//  Created by Adrian on 10/18/08.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RESTClient;

@protocol RESTClientDelegate

@required
- (void)wrapper:(RESTClient*)wrapper didRetrieveData:(NSData*)data;

@optional
- (void)wrapperHasBadCredentials : (RESTClient*)wrapper;
- (void)wrapper:(RESTClient*)wrapper didCreateResourceAtURL:(NSString*)url;
- (void)wrapper:(RESTClient*)wrapper didFailWithError:(NSError*)error;
- (void)wrapper:(RESTClient*)wrapper didReceiveStatusCode:(int)statusCode;

@end
