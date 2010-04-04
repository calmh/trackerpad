//
//  RootViewController.h
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class Tracker;
@class TrackerPadAppDelegate;
@class TrackerProject;

@interface RootViewController : UITableViewController {
        DetailViewController *detailViewController;
        Tracker *tracker;
        NSArray *projects;
        TrackerProject *currentProject;
        TrackerPadAppDelegate *delegate;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) TrackerProject *currentProject;

@end
