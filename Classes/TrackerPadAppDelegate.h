//
//  TrackerPadAppDelegate.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tracker.h"

@class TrackerPadViewController;

@interface TrackerPadAppDelegate : NSObject <UIApplicationDelegate> {
        UIWindow *window;
        TrackerPadViewController *viewController;
        Tracker *tracker;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TrackerPadViewController *viewController;
@property (nonatomic, retain) Tracker* tracker;

@end
