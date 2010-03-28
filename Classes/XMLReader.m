//
//  XMLReader.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "XMLReader.h"
#import "Wrapper.h"

@implementation XMLReader

- (void) dealloc {
	[tbxml release];
	[super dealloc];
}

- (id) init {
	if (self = [super init]) {
		tbxml = nil;
	}
	return self;
}

- (id) initWithTBXML:(TBXML*)theTbxml {
	if (self = [super init]) {
		tbxml = [theTbxml retain];
	}
	return self;
}

- (TBXML*) xmlForURLString:(NSString*)urlString withUsername:(NSString*)username andPassword:(NSString*)password {
	if (tbxml == nil) {
		NSURL *url = [self urlForPath:urlString];
		Wrapper *wrapper = [[Wrapper alloc] init];
		wrapper.asynchronous = NO;
		[wrapper sendRequestTo:url usingVerb:@"POST" withParameters:[NSDictionary dictionaryWithObjectsAndKeys:username, @"username", password, @"password", nil] andHeaders:nil];
		tbxml = [[TBXML tbxmlWithXMLData:wrapper.receivedData] retain];
		[wrapper release];
	}
		
	return tbxml;
}

- (TBXML*) xmlForURLString:(NSString*)urlString withToken:(NSString*)token {
	if (tbxml == nil) {
		NSURL *url = [self urlForPath:urlString];
		Wrapper *wrapper = [[Wrapper alloc] init];
		wrapper.asynchronous = NO;
		[wrapper sendRequestTo:url
			     usingVerb:@"GET"
			withParameters:nil
			    andHeaders:[NSDictionary dictionaryWithObjectsAndKeys:token, @"X-TrackerToken", nil]];
		tbxml = [[TBXML tbxmlWithXMLData:wrapper.receivedData] retain];
		[wrapper release];
	}
	
	return tbxml;
}

- (NSURL*) urlForPath:(NSString*)path {
	return [NSURL URLWithString:[NSString stringWithFormat:@"https://www.pivotaltracker.com/services/v3/%@", path]];
}

@end
