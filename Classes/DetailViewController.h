//
//  DetailViewController.h
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IterationViewController;
@class Tracker;
@class TrackerPadAppDelegate;
@class TrackerProject;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
        UIPopoverController *popoverController;
        UIToolbar *toolbar;
        TrackerProject *project;
        Tracker *tracker;
        IterationViewController *leftController, *rightController;
        TrackerPadAppDelegate *delegate;
}

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (assign) TrackerProject *project;

@end
