//
//  EntitiesTests.m
//  TrackerPad
//
//  Created by Jakob Borg on 4/5/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "EntitiesTests.h"
#import "MREntitiesConverter.h"

@implementation EntitiesTests

- (void)testNamedEntity
{
        NSString *entitityString = @"A &quot;test &amp; testing&quot; string.";
        MREntitiesConverter *converter = [[MREntitiesConverter alloc] init];
        NSString *convertedString = [converter convertEntiesInString:entitityString];
        STAssertEqualObjects(convertedString, @"A \"test & testing\" string.", nil);
        [converter release];
}

- (void)testNumericEntity
{
        NSString *entitityString = @"R&#228;ksm&#246;rg&#229;s";
        MREntitiesConverter *converter = [[MREntitiesConverter alloc] init];
        NSString *convertedString = [converter convertEntiesInString:entitityString];
        STAssertEqualObjects(convertedString, @"Räksmörgås", nil);
        [converter release];
}

@end
