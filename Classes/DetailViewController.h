//
//  DetailViewController.h
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "IterationViewController.h"
#import "Tracker.h"
#import "TrackerProject.h"
#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> {
        UIPopoverController *popoverController;
        UIToolbar *toolbar;

        TrackerProject *project;
        Tracker *tracker;

        IterationViewController *leftController, *rightController;
}

@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (assign) TrackerProject *project;

@end
