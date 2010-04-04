//
//  IterationViewController.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/30/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoryTableViewCell;
@class TrackerPadAppDelegate;
@class TrackerProject;

typedef enum {
        Done,
        Current,
        Backlog,
        Icebox
} IterationEnum;

@interface IterationViewController : UITableViewController {
        UIView *containerView;
        UISegmentedControl *iterationsSelector;
        NSArray *iterations;
        NSInteger index;
        TrackerProject *project;
        StoryTableViewCell *tableViewCell;
        TrackerPadAppDelegate *delegate;
}

@property (nonatomic, retain) IBOutlet UIView *containerView;
@property (nonatomic, assign) IBOutlet UISegmentedControl *iterationsSelector;
@property (nonatomic, retain) NSArray *iterations;
@property (nonatomic, retain) TrackerProject *project;
@property (nonatomic, assign) IBOutlet StoryTableViewCell *tableViewCell;
@property (nonatomic, assign) NSInteger index;

- (void)setIteration:(IterationEnum)iteration;
- (IBAction)iterationControlChangedValue:(UISegmentedControl*)event;

@end
