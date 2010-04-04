//
//  RootViewController.m
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "TrackerPadAppDelegate.h"
#import "TrackerProject.h"

@implementation RootViewController

@synthesize detailViewController;
@synthesize currentProject;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
        [super viewDidLoad];
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
}

- (void)viewWillAppear:(BOOL)animated
{
        tracker = [(TrackerPadAppDelegate*)[[UIApplication sharedApplication] delegate] tracker];
        projects = [[tracker projects] retain];
        [self.tableView reloadData];
        [super viewWillAppear:animated];
}

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

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return YES;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView*)aTableView
{
        return 1;
}

- (NSInteger)tableView:(UITableView*)aTableView numberOfRowsInSection:(NSInteger)section
{
        NSInteger num_projects = [projects count];
        return num_projects;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
        NSString *cellIdentifier;
        UITableViewCell *cell;

        cellIdentifier = @"ProjectCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];
                cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        }

        cell.textLabel.text = [(TrackerProject*)[[tracker projects] objectAtIndex:indexPath.row] name];
        return cell;
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

- (void)tableView:(UITableView*)aTableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
        self.currentProject = [projects objectAtIndex:indexPath.row];
        detailViewController.project = self.currentProject;
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning
{
        // Releases the view if it doesn't have a superview.
        [super didReceiveMemoryWarning];

        // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
        // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
        // For example: self.myOutlet = nil;
}

- (void)dealloc
{
        [detailViewController release];
        [super dealloc];
}

@end
