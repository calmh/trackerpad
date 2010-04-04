//
//  IterationViewController.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/30/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "StoryTableViewCell.h"
#import "TrackerIteration.h"
#import "TrackerProject.h"
#import <UIKit/UIKit.h>

@interface IterationViewController : UITableViewController {
        UIView *containerView;
        NSArray *iterations;
        TrackerProject *project;
        StoryTableViewCell *tableViewCell;
}

@property (nonatomic, retain) IBOutlet UIView *containerView;
@property (nonatomic, retain) NSArray *iterations;
@property (nonatomic, retain) TrackerProject *project;
@property (nonatomic, assign) IBOutlet StoryTableViewCell *tableViewCell;

@end
