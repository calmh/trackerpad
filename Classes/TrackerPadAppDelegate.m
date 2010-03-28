//
//  TrackerPadAppDelegate.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "TrackerPadAppDelegate.h"
#import "TrackerPadViewController.h"

@implementation TrackerPadAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication*)application
{
        // Override point for customization after app launch
        [window addSubview:viewController.view];
        [window makeKeyAndVisible];
}

- (void)dealloc
{
        [viewController release];
        [window release];
        [super dealloc];
}

@end
