//
//  TrackerPadAppDelegate.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tracker.h"
#import "RootViewController.h"
#import "DetailViewController.h"

@class TrackerPadViewController;

@interface TrackerPadAppDelegate : NSObject <UIApplicationDelegate> {
        Tracker *tracker;

        UIWindow *window;
        UISplitViewController *splitViewController;
        RootViewController *rootViewController;
        DetailViewController *detailViewController;
}

@property (nonatomic, retain) Tracker* tracker;
@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UISplitViewController *splitViewController;
@property (nonatomic, retain) IBOutlet RootViewController *rootViewController;
@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;

@end
