//
//  TrackerPadAppDelegate.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "Tracker.h"
#import "TrackerPadAppDelegate.h"

@implementation TrackerPadAppDelegate

@synthesize window;
@synthesize tracker;
@synthesize splitViewController, rootViewController, detailViewController;

- (void)applicationDidFinishLaunching:(UIApplication*)application
{
        tracker = [[Tracker alloc] initWithToken:[[NSUserDefaults standardUserDefaults] stringForKey:@"token"]];
        [window addSubview:splitViewController.view];
        [window makeKeyAndVisible];
        defaults = [NSUserDefaults standardUserDefaults];
}

- (void)applicationWillTerminate:(UIApplication*)application
{
        [[NSUserDefaults standardUserDefaults] synchronize];
}

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
