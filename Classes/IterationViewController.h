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
@class PTProject;

typedef enum {
        Done,
        Current,
        Backlog,
        Icebox
} IterationEnum;

@interface IterationViewController : UITableViewController {
        UISegmentedControl *iterationsSelector;
        NSArray *iterations;
        NSInteger index;
        PTProject *project;
        StoryTableViewCell *tableViewCell;
        TrackerPadAppDelegate *delegate;
}

@property (nonatomic, assign) IBOutlet UISegmentedControl *iterationsSelector;
@property (nonatomic, retain) NSArray *iterations;
@property (nonatomic, retain) PTProject *project;
@property (nonatomic, assign) IBOutlet StoryTableViewCell *tableViewCell;
@property (nonatomic, assign) NSInteger index;

- (void)setIteration:(IterationEnum)iteration;
- (IBAction)iterationControlChangedValue:(UISegmentedControl*)event;

@end
