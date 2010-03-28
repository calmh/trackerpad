//
//  ProjectTests.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "ProjectTests.h"
#import "TBXML.h"
#import "PTProjects.h"

@implementation ProjectTests

- (void) testGetProjectList {
	NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
	TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
	PTProjects *projects = [[PTProjects alloc] initWithTBXML:xml];
	NSArray *projectList = [projects getProjectListWithToken:@"not necessary"];
	STAssertEquals(1u, [projectList count], nil);
	STAssertTrue([[projectList objectAtIndex:0] isEqualToString:@"Test project"], nil);
}

- (void) testGetProjectListFromWeb {
	PTProjects *projects = [[PTProjects alloc] init];
	NSArray *projectList = [projects getProjectListWithToken:@"b590dc2ef47a9bdcead1a5d1d128c18f"];
	STAssertEquals(1u, [projectList count], nil);
	STAssertTrue([[projectList objectAtIndex:0] isEqualToString:@"Test project"], nil);
}

@end
