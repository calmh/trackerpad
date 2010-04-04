//
//  TrackerPadAppDelegate.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "TrackerClient.h"
#import "TrackerPadAppDelegate.h"

@implementation TrackerPadAppDelegate

@synthesize window;
@synthesize tracker;
@synthesize splitViewController, rootViewController, detailViewController;

- (void)applicationDidFinishLaunching:(UIApplication*)application
{
        tracker = [[TrackerClient alloc] initWithToken:[[NSUserDefaults standardUserDefaults] stringForKey:@"token"]];
        [window addSubview:splitViewController.view];
        [window makeKeyAndVisible];
        defaults = [NSUserDefaults standardUserDefaults];
}

- (void)applicationWillTerminate:(UIApplication*)application
{
        [[NSUserDefaults standardUserDefaults] synchronize];
}

// Get and set the default (last selected) project.

- (NSInteger)defaultProject
{
        NSString *key = [NSString stringWithFormat:@"rootViewSelectedProject"];
        NSInteger defaultProject = [defaults integerForKey:key];
        return defaultProject;
}

- (void)setDefaultProject:(NSInteger)value
{
        NSString *key = [NSString stringWithFormat:@"rootViewSelectedProject"];
        [defaults setInteger:value forKey:key];
}

// Get and set the default state (current, done, backlog, etc.) for a certain pane in a project.
// Pane index 0 is left, 1 is right.

- (NSInteger)defaultStateForProject:(NSInteger)project andPane:(NSInteger)index
{
        NSString *key = [NSString stringWithFormat:@"iterationsController_state_%u_%d", project, index];
        NSInteger defaultProject = [defaults integerForKey:key];
        return defaultProject;
}

- (void)setDefaultState:(NSInteger)value forProject:(NSInteger)project andPane:(NSInteger)index
{
        NSString *key = [NSString stringWithFormat:@"iterationsController_state_%u_%d", project, index];
        [defaults setInteger:value forKey:key];
}

@end
