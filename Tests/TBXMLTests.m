//
//  TBXMLTests.m
//  TrackerPad
//
//  Created by Jakob Borg on 4/4/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "TBXML.h"
#import "TBXMLTests.h"

@implementation TBXMLTests

- (void)testChildElementOfNilIsNil
{
        TBXMLElement *nilRoot = nil;
        TBXMLElement *nilChild = [TBXML childElementNamed:@"nothing" parentElement:nilRoot];
        STAssertNil(nilChild, nil);
}

- (void)testUnknownChildElementIsNil
{
        NSString *filename = [NSString stringWithFormat:@"%@/iterations-current.xml", [self bundlePath]];
        TBXML *xml = [TBXML tbxmlWithXMLFile:filename];
        TBXMLElement *nilChild = [TBXML childElementNamed:@"nothing" parentElement:xml.rootXMLElement];
        STAssertNil(nilChild, nil);
}

- (void)testTextForNilElementIsNil
{
        NSString *nilText = [TBXML textForElement:nil];
        STAssertNil(nilText, nil);
}

@end
