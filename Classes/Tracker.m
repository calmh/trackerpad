//
//  Tracker.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "Tracker.h"
#import "Wrapper.h"

@interface Tracker (Private)

- (TBXML*) xmlForURLString:(NSString*)url withUsername:(NSString*)username andPassword:(NSString*)password;
- (TBXML*) xmlForURLString:(NSString*)url withToken:(NSString*)token;
- (NSURL*) urlForPath:(NSString*)path;

@end


@implementation Tracker

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

#pragma mark Public functions

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

- (NSArray*) getProjectListWithToken:(NSString*)token {
	TBXML *xml = [self xmlForURLString:@"projects" withToken:token];
	
	TBXMLElement *rootElement = xml.rootXMLElement;
	assert(rootElement != nil);
	
	NSMutableArray *projects = [[[NSMutableArray alloc] init] autorelease];
	TBXMLElement *projectElement = [TBXML childElementNamed:@"project" parentElement:rootElement];
	while (projectElement != nil) {
		TBXMLElement *name = [TBXML childElementNamed:@"name" parentElement:projectElement];
		assert(name != nil);
		[projects addObject:[TBXML textForElement:name]];
		projectElement = [TBXML nextSiblingNamed:@"project" searchFromElement:projectElement];
	}
	
	return projects;
}

#pragma mark Private functions

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
