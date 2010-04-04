//
//  AuthenticationTests.m
//  NNPivotalTracker
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "AuthenticationTests.h"
#import "Tracker.h"

@implementation AuthenticationTests

- (void)setUp {}

- (void)tearDown {}

- (void)testGetToken
{
        NSString *filename = [NSString stringWithFormat:@"%@/token.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];

        NSString *token = [tracker getTokenForUsername:@"test" andPassword:@"test"];
        STAssertEqualObjects(token, @"c93f12c71bec27843c1d84b3bdd547f3", nil);

        [tracker release];
}

#ifdef DO_WEB_TESTS
- (void)testGetTokenFromWeb
{
        Tracker *tracker = [[Tracker alloc] init];

        NSString *token = [tracker getTokenForUsername:@"ano@nym.se" andPassword:@"tester"];
        STAssertEqualObjects(token, @"b590dc2ef47a9bdcead1a5d1d128c18f", nil);

        [tracker release];
}

#endif
@end
