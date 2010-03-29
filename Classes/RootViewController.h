//
//  RootViewController.h
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "Tracker.h"
#import "TrackerProject.h"
#import <UIKit/UIKit.h>

@class DetailViewController;

@interface RootViewController : UITableViewController {
        DetailViewController *detailViewController;
        Tracker *tracker;
        NSArray *projects;
        TrackerProject *currentProject;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) TrackerProject *currentProject;

@end
