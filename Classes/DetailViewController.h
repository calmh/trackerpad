//
//  DetailViewController.h
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IterationViewController;
@class TrackerClient;
@class TrackerPadAppDelegate;
@class PTProject;

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
        UIPopoverController *popoverController;
        UIToolbar *toolbar;
        PTProject *project;
        TrackerClient *tracker;
        UIView *leftView, *rightView;
        IterationViewController *leftController, *rightController;
        UISegmentedControl *leftSelector, *rightSelector;
        TrackerPadAppDelegate *delegate;
}

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;
@property (nonatomic, retain) IBOutlet IterationViewController *leftController, *rightController;
@property (nonatomic, retain) IBOutlet UIView *leftView, *rightView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *leftSelector, *rightSelector;
@property (assign) PTProject *project;

@end
