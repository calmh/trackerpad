//
//  TrackerPadViewController.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/27/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "ProjectsTableViewController.h"
#import "StoriesTableViewController.h"
#import <UIKit/UIKit.h>

@interface TrackerPadViewController : UIViewController {
        ProjectsTableViewController *projectsTableViewController;
        StoriesTableViewController *storiesTableViewController;
}

@property (retain, nonatomic) IBOutlet ProjectsTableViewController *projectsTableViewController;
@property (retain, nonatomic) IBOutlet StoriesTableViewController *storiesTableViewController;

@end
