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
@synthesize projects;

- (void)applicationDidFinishLaunching:(UIApplication*)application
{
        NSLog(@"ApplicationDidFinishLaunching initializing");
        defaults = [NSUserDefaults standardUserDefaults];
        tracker = [[TrackerClient alloc] initWithToken:[[NSUserDefaults standardUserDefaults] stringForKey:@"token"]];
        projects = [[tracker projects] retain];
        NSLog(@"ApplicationDidFinishLaunching starting");
        [window addSubview:splitViewController.view];
        [window makeKeyAndVisible];
        NSLog(@"ApplicationDidFinishLaunching done");
}

- (void)applicationWillTerminate:(UIApplication*)application
{
        [[NSUserDefaults standardUserDefaults] synchronize];
}

// Get and set the default (last selected) project.

- (NSInteger)currentProjectIndex
{
        NSString *key = [NSString stringWithFormat:@"rootViewSelectedProject"];
        NSInteger defaultProject = [defaults integerForKey:key];
        return defaultProject;
}

- (void)setCurrentProjectIndex:(NSInteger)value
{
        NSString *key = [NSString stringWithFormat:@"rootViewSelectedProject"];
        [defaults setInteger:value forKey:key];
}

- (PTProject*)currentProject
{
        return [projects objectAtIndex:self.currentProjectIndex];
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
