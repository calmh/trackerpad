//
//  PTAuthentication.m
//  NNPivotalTracker
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "PTAuthentication.h"

@implementation PTAuthentication

- (NSString*) getTokenForUsername:(NSString*)username andPassword:(NSString*)password {
	TBXML *xml = [self xmlForURLString:@"tokens/active" withUsername:username andPassword:password];

	TBXMLElement *rootElement = xml.rootXMLElement;
	assert(rootElement != nil);
	
	NSLog(@"Foo");
	TBXMLElement *guidElement = [TBXML childElementNamed:@"guid" parentElement:rootElement];
	assert(guidElement != nil);
	
	NSLog(@"Foo");
	return [TBXML textForElement:guidElement];
}

@end
