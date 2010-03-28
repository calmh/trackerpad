//
//  TrackerPadTest.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/28/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "TrackerPadTest.h"


@implementation TrackerPadTest

- (NSString*)bundlePath
{
        NSBundle *myBundle = [NSBundle bundleForClass:[self class]];
        NSString *bundlePath = [myBundle bundlePath];
        return bundlePath;
}

@end
