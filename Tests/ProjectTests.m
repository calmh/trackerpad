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
#import "TrackerPerson.h"
#import "TrackerProject.h"

@implementation ProjectTests

- (void)setUp {}

- (void)tearDown {}

- (void)verifyTestProject:(TrackerProject*)project
{
        STAssertEquals(project.id, 69227u, nil);
        STAssertEqualObjects(project.name, @"Test project", nil);
        STAssertEquals(project.velocity, 3, nil);
}

- (void)testGetProjectList
{
        NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        STAssertEquals([projectList count], 1u, nil);
        TrackerProject *project = [projectList objectAtIndex:0];
        [self verifyTestProject:project];

        [tracker release];
}

#ifdef DO_WEB_TESTS
- (void)testGetProjectListFromWeb
{
        Tracker *tracker = [[Tracker alloc] initWithToken:@"b590dc2ef47a9bdcead1a5d1d128c18f"];
        NSArray *projectList = [tracker projects];

        STAssertEquals([projectList count], 1u, nil);

        TrackerProject *project = [projectList objectAtIndex:0];
        [self verifyTestProject:project];

        [tracker release];
}

#endif

- (void)testShouldHaveOneMember
{
        NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        TrackerProject *project = [projectList objectAtIndex:0];
        STAssertEquals([[project members] count], 1u, nil);
        //TrackerPerson *person = [[project members] objectAtIndex:0];

        [tracker release];
}

- (void)testMemberValues
{
        NSString *filename = [NSString stringWithFormat:@"%@/projects.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        TrackerProject *project = [projectList objectAtIndex:0];
        TrackerPerson *person = [[project members] objectAtIndex:0];

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
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        TrackerProject *project = [projectList objectAtIndex:0];
        TrackerPerson *person = [project memberNamed:@"Test Testsson"];

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
        Tracker *tracker = [[Tracker alloc] initWithTBXML:xml];
        NSArray *projectList = [tracker projects];

        TrackerProject *project = [projectList objectAtIndex:0];
        TrackerPerson *person = [project memberNamed:@"No Such"];

        STAssertNil(person, nil);

        [tracker release];
}

@end
