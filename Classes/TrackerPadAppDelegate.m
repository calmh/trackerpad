//
//  TrackerPadAppDelegate.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "TrackerPadAppDelegate.h"

@implementation TrackerPadAppDelegate

@synthesize window;
@synthesize tracker;
@synthesize splitViewController, rootViewController, detailViewController;

- (void)applicationDidFinishLaunching:(UIApplication*)application
{
        tracker = [[Tracker alloc] initWithToken:[[NSUserDefaults standardUserDefaults] stringForKey:@"token"]];
        // Override point for customization after app launch
        [window addSubview:splitViewController.view];
        [window makeKeyAndVisible];
}

@end
