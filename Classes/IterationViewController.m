//
//  IterationViewController.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/30/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "IterationViewController.h"
#import "TrackerStory.h"

@interface IterationViewController (Private)
- (StoryTableViewCell*)loadCell;
@end

@implementation IterationViewController

@synthesize containerView;
@synthesize iterations;
@synthesize project;
@synthesize tableViewCell;

- (void)setIterations:(NSArray*)newIterations
{
        if (newIterations != iterations) {
                [iterations release];
                iterations = [newIterations retain];
                [self.tableView reloadData];
        }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
        return [iterations count];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
        TrackerIteration *iteration = [iterations objectAtIndex:section];
        return [iteration.stories count];
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 300.0, 16.0)];
        label.backgroundColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.5];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];

        TrackerIteration *iteration = [iterations objectAtIndex:section];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd"];
        label.text = [NSString stringWithFormat:@" %@ - %@",
                      [formatter stringFromDate:iteration.start],
                      [formatter stringFromDate:iteration.finish]];
        return label;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
        return 26.0;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
        static NSString *CellIdentifier = @"StoryTableViewCell";

        StoryTableViewCell *cell = (StoryTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
                cell = [self loadCell];

        TrackerIteration *iteration = [iterations objectAtIndex:indexPath.section];
        TrackerStory *story = [iteration.stories objectAtIndex:indexPath.row];

        cell.textLabel.text = story.name;
        if (story.owner == nil)
                cell.ownerLabel.text = @"";
        else {
                TrackerPerson *person = [project memberNamed:story.owner];
                cell.ownerLabel.text = person.initials;
        }

        [cell setPoints:story.estimate];
        [cell setType:story.type];
        [cell setState:story.state];

        return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
        if (tableViewCell == nil)
                [self loadCell];

        TrackerIteration *iteration = [iterations objectAtIndex:indexPath.section];
        TrackerStory *story = [iteration.stories objectAtIndex:indexPath.row];
        UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        CGSize withinSize = CGSizeMake(tableViewCell.textLabel.frame.size.width, 1000);
        CGSize size = [story.name sizeWithFont:font constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];

        CGFloat height = size.height + (47 - 34);
        if (height < 47)
                height = 47;
        return height;
}

- (void)didReceiveMemoryWarning
{
        [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
        self.tableViewCell = nil;
}

- (void)dealloc
{
        [super dealloc];
}

- (StoryTableViewCell*)loadCell
{
        [[NSBundle mainBundle] loadNibNamed:@"StoryTableViewCell" owner:self options:nil];
        return self.tableViewCell;
}

@end
