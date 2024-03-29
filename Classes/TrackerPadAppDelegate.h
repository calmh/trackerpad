//
//  TrackerPadAppDelegate.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class IterationViewController;
@class PTProject;
@class RootViewController;
@class TrackerClient;
@class TrackerPadViewController;

@interface TrackerPadAppDelegate : NSObject <UIApplicationDelegate> {
        TrackerClient *tracker;
        NSUserDefaults *defaults;

        UIWindow *window;
        UISplitViewController *splitViewController;
        RootViewController *rootViewController;
        DetailViewController *detailViewController;

        PTProject *currentProject;
        NSArray *projects;
}

@property (nonatomic, retain) TrackerClient *tracker;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property NSInteger currentProjectIndex;
@property (readonly) PTProject *currentProject;
@property (readonly) NSArray *projects;

- (NSInteger)defaultStateForProject:(NSInteger)project andPane:(NSInteger)index;
- (void)setDefaultState:(NSInteger)value forProject:(NSInteger)project andPane:(NSInteger)index;

@end
