//
//  RootViewController.h
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;
@class TrackerClient;
@class TrackerPadAppDelegate;
@class PTProject;

@interface RootViewController : UITableViewController {
        DetailViewController *detailViewController;
        TrackerClient *tracker;
        NSArray *projects;
        PTProject *currentProject;
        TrackerPadAppDelegate *delegate;
}

@property (nonatomic, retain) IBOutlet DetailViewController *detailViewController;
@property (nonatomic, retain) PTProject *currentProject;

@end
