//
//  IterationViewController.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/30/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "IterationViewController.h"
#import "PTIteration.h"
#import "PTPerson.h"
#import "PTProject.h"
#import "PTStory.h"
#import "StoryTableViewCell.h"
#import "TrackerClient.h"
#import "TrackerPadAppDelegate.h"

@interface IterationViewController (Private)
- (StoryTableViewCell*)loadCell;
@end

@implementation IterationViewController

@synthesize iterationsSelector;
@synthesize iterations;
@synthesize project;
@synthesize tableViewCell;
@synthesize index;

- (void)viewDidLoad
{
        [super viewDidLoad];
        delegate = [[UIApplication sharedApplication] delegate];
}

- (void)setIteration:(IterationEnum)iteration
{
        iterationsSelector.selectedSegmentIndex = (NSInteger)iteration;

        TrackerClient *tracker = [(TrackerPadAppDelegate*)[[UIApplication sharedApplication] delegate] tracker];
        if (iteration == Done)
                self.iterations = [tracker doneIterationsInProject:project.id];
        else if (iteration == Current)
                self.iterations = [NSArray arrayWithObject:[tracker currentIterationInProject:project.id]];
        else if (iteration == Backlog)
                self.iterations = [tracker backlogIterationsInProject:project.id];
        else if (iteration == Icebox)
                self.iterations = [NSArray arrayWithObject:[tracker iceboxIterationInProject:project.id]];

        [delegate setDefaultState:iteration forProject:project.id andPane:index];
        [self.tableView reloadData];
}

- (IBAction)iterationControlChangedValue:(UISegmentedControl*)control
{
        IterationEnum value = control.selectedSegmentIndex;
        [self setIteration:value];
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
        PTIteration *iteration = [iterations objectAtIndex:section];
        return [iteration.stories count];
}

- (UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
        UIImage *background = [UIImage imageNamed:@"header-background.png"];
        UIImageView *container = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 300.0, 21.0)] autorelease];
        container.image = background;
        container.contentStretch = CGRectMake(0.0, 0.0, 300.0, 21.0);

        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 290.0, 16.0)] autorelease];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        label.shadowColor = [UIColor darkGrayColor];
        label.shadowOffset = CGSizeMake(0, 1);
        [container addSubview:label];

        PTIteration *iteration = [iterations objectAtIndex:section];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM dd"];
        label.text = [NSString stringWithFormat:@"%@ - %@",
                      [formatter stringFromDate:iteration.start],
                      [formatter stringFromDate:iteration.finish]];

        return container;
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

        PTIteration *iteration = [iterations objectAtIndex:indexPath.section];
        PTStory *story = [iteration.stories objectAtIndex:indexPath.row];

        cell.textLabel.text = story.name;
        if (story.owner == nil)
                cell.ownerLabel.text = @"";
        else {
                PTPerson *person = [project memberNamed:story.owner];
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

        PTIteration *iteration = [iterations objectAtIndex:indexPath.section];
        PTStory *story = [iteration.stories objectAtIndex:indexPath.row];
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
