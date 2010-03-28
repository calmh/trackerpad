//
//  PTProjects.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "PTProjects.h"

@implementation PTProjects

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

@end
