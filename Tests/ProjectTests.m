//
//  ProjectTests.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "PTPerson.h"
#import "PTProject.h"
#import "ProjectTests.h"
#import "TBXML.h"
#import "TrackerClient.h"

@implementation ProjectTests

- (void)setUp {}

- (void)tearDown {}

- (void)verifyTestProject:(PTProject*)project
{
        STAssertEquals(project.id, 69227u, nil);
        STAssertEqualObjects(project.name, @"Test project", nil);
        STAssertEquals(project.velocity, 3, nil);
}

- (void)testGetProjectList
{
        NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        TrackerClient *tracker = [[TrackerClient alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        STAssertEquals([projectList count], 1u, nil);
        PTProject *project = [projectList objectAtIndex:0];
        [self verifyTestProject:project];

        [tracker release];
}

#ifdef DO_WEB_TESTS
- (void)testGetProjectListFromWeb
{
        TrackerClient *tracker = [[TrackerClient alloc] initWithToken:@"b590dc2ef47a9bdcead1a5d1d128c18f"];
        NSArray *projectList = [tracker projects];

        STAssertEquals([projectList count], 1u, nil);

        PTProject *project = [projectList objectAtIndex:0];
        [self verifyTestProject:project];

        [tracker release];
}

#endif

- (void)testShouldHaveOneMember
{
        NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        TrackerClient *tracker = [[TrackerClient alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        PTProject *project = [projectList objectAtIndex:0];
        STAssertEquals([[project members] count], 1u, nil);
        //PTPerson *person = [[project members] objectAtIndex:0];

        [tracker release];
}

- (void)testMemberValues
{
        NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        TrackerClient *tracker = [[TrackerClient alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        PTProject *project = [projectList objectAtIndex:0];
        PTPerson *person = [[project members] objectAtIndex:0];

        STAssertEquals(person.id, 235284u, nil);
        STAssertEqualObjects(person.email, @"ano@nym.se", nil);
        STAssertEqualObjects(person.name, @"Test Testsson", nil);
        STAssertEqualObjects(person.initials, @"TT", nil);
        STAssertEqualObjects(person.role, @"Owner", nil);

        [tracker release];
}

- (void)testNamedMemberValues
{
        NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        TrackerClient *tracker = [[TrackerClient alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        PTProject *project = [projectList objectAtIndex:0];
        PTPerson *person = [project memberNamed:@"Test Testsson"];

        STAssertEquals(person.id, 235284u, nil);
        STAssertEqualObjects(person.email, @"ano@nym.se", nil);
        STAssertEqualObjects(person.name, @"Test Testsson", nil);
        STAssertEqualObjects(person.initials, @"TT", nil);
        STAssertEqualObjects(person.role, @"Owner", nil);

        [tracker release];
}

- (void)testNoSuchMember
{
        NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        TrackerClient *tracker = [[TrackerClient alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        PTProject *project = [projectList objectAtIndex:0];
        PTPerson *person = [project memberNamed:@"No Such"];

        STAssertNil(person, nil);

        [tracker release];
}

@end
