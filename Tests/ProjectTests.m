//
//  ProjectTests.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "ProjectTests.h"
#import "TBXML.h"
#import "Tracker.h"

@implementation ProjectTests

- (void) testGetProjectList {
	NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
	TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
	Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
	NSArray *projectList = [tracker getProjectListWithToken:@"not necessary"];
	STAssertEquals(1u, [projectList count], nil);
	STAssertTrue([[projectList objectAtIndex:0] isEqualToString:@"Test project"], nil);

	[tracker release];
}

- (void) testGetProjectListFromWeb {
	Tracker *tracker = [[Tracker alloc] init];
	NSArray *projectList = [tracker getProjectListWithToken:@"b590dc2ef47a9bdcead1a5d1d128c18f"];
	STAssertEquals(1u, [projectList count], nil);
	STAssertTrue([[projectList objectAtIndex:0] isEqualToString:@"Test project"], nil);
	
	[tracker release];
}

@end
