//
//  AuthenticationTests.m
//  NNPivotalTracker
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "AuthenticationTests.h"

@implementation AuthenticationTests

- (void) setUp {
}

- (void) tearDown {
}

- (void) testGetToken {
	NSString *filename = [NSString stringWithFormat:@"%@/token.xml", [self bundlePath]];
	TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
	PTAuthentication *auth = [[PTAuthentication alloc] initWithTBXML:xml];
	
	NSString *token = [auth getTokenForUsername: @"test" andPassword: @"test"];
	STAssertTrue([@"c93f12c71bec27843c1d84b3bdd547f3" isEqualToString: token], nil);
	
	[auth release];
}

- (void) testGetTokenFromWeb {	
	PTAuthentication *auth = [[PTAuthentication alloc] init];
	
	NSString *token = [auth getTokenForUsername: @"ano@nym.se" andPassword: @"tester"];
	STAssertTrue([@"b590dc2ef47a9bdcead1a5d1d128c18f" isEqualToString: token], nil);
	
	[auth release];
}

@end
