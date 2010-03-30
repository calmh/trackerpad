//
//  IterationViewController.m
//  TrackerPad
//
//  Created by Jakob Borg on 3/30/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "IterationViewController.h"
#import "TrackerStory.h"

@implementation IterationViewController

@synthesize iterations;

- (void)setIterations:(NSArray*)newIterations
{
        if (newIterations != iterations) {
                [iterations release];
                iterations = [newIterations retain];
                [self.tableView reloadData];
        }
}

#pragma mark -
#pragma mark Initialization

/*
   - (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
   }
 */


#pragma mark -
#pragma mark View lifecycle

/*
   - (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
   }
 */

/*
   - (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   }
 */
/*
   - (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   }
 */
/*
   - (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   }
 */
/*
   - (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
   }
 */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        // Override to allow orientations other than the default portrait orientation.
        return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
        // Return the number of sections.
        return [iterations count];
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
        // Return the number of rows in the section.
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
        label.text = [NSString stringWithFormat:@"%@ - %@",
                      [formatter stringFromDate:iteration.start],
                      [formatter stringFromDate:iteration.finish]];
        return label;
}

- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
        return 26.0;
}

// Customize the appearance of table view cells.
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
        static NSString *CellIdentifier = @"Cell";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
                cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                cell.textLabel.numberOfLines = 0;
                cell.textLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        }

        TrackerIteration *iteration = [iterations objectAtIndex:indexPath.section];
        TrackerStory *story = [iteration.stories objectAtIndex:indexPath.row];
        cell.textLabel.text = story.name;

        return cell;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
        TrackerIteration *iteration = [iterations objectAtIndex:indexPath.section];
        TrackerStory *story = [iteration.stories objectAtIndex:indexPath.row];
        UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        CGSize withinSize = CGSizeMake(tableView.frame.size.width, 1000);
        CGSize size = [story.name sizeWithFont:font constrainedToSize:withinSize lineBreakMode:UILineBreakModeWordWrap];

        return size.height + 20;
}

/*
   // Override to support conditional editing of the table view.
   - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
   }
 */


/*
   // Override to support editing the table view.
   - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
   }
 */


/*
   // Override to support rearranging the table view.
   - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
   }
 */


/*
   // Override to support conditional rearranging of the table view.
   - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
   }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
        // Navigation logic may go here. Create and push another view controller.
        /*
           <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
           // ...
           // Pass the selected object to the new view controller.
           [self.navigationController pushViewController:detailViewController animated:YES];
           [detailViewController release];
         */
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
        // Releases the view if it doesn't have a superview.
        [super didReceiveMemoryWarning];

        // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
        // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
        // For example: self.myOutlet = nil;
}

- (void)dealloc
{
        [super dealloc];
}

@end
