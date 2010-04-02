//
//  DetailViewController.m
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "TrackerPadAppDelegate.h"

@interface DetailViewController ()
@property (nonatomic, retain) UIPopoverController *popoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize toolbar, popoverController, project;

#pragma mark -
#pragma mark Managing the detail item

/*
   When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */
- (void)setProject:(TrackerProject*)newProject
{
        if (project != newProject) {
                [project release];
                project = [newProject retain];

                // Update the view.
                [self configureView];
        }

        if (popoverController != nil)
                [popoverController dismissPopoverAnimated:YES];
}

- (void)configureView
{
        // TODO: Handle this in an appropriate way that doesn't leak all over the place.

        IterationViewController *curIvc = [[IterationViewController alloc] initWithStyle:UITableViewStylePlain];
        curIvc.iterations = [NSArray arrayWithObject:[tracker currentIterationInProject:project.id]];
        CGRect detailFrame = [self.view frame];
        CGRect curFrame = [curIvc.view frame];
        curIvc.view.frame = CGRectMake(curFrame.origin.x, curFrame.origin.y + self.toolbar.frame.size.height, detailFrame.size.width / 2, detailFrame.size.height - self.toolbar.frame.size.height);
        [self.view addSubview:curIvc.view];

        IterationViewController *backIvc = [[IterationViewController alloc] initWithStyle:UITableViewStylePlain];
        backIvc.iterations = [tracker backlogIterationsInProject:project.id];
        CGRect backFrame = [backIvc.view frame];
        backIvc.view.frame = CGRectMake(backFrame.origin.x + detailFrame.size.width / 2, backFrame.origin.y + self.toolbar.frame.size.height, detailFrame.size.width / 2, detailFrame.size.height - self.toolbar.frame.size.height);
        [self.view addSubview:backIvc.view];
}

#pragma mark -
#pragma mark Split view support

- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController*)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc
{
        barButtonItem.title = @"Root List";
        NSMutableArray *items = [[toolbar items] mutableCopy];
        [items insertObject:barButtonItem atIndex:0];
        [toolbar setItems:items animated:YES];
        [items release];
        self.popoverController = pc;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController*)aViewController invalidatingBarButtonItem:(UIBarButtonItem*)barButtonItem
{
        NSMutableArray *items = [[toolbar items] mutableCopy];
        [items removeObjectAtIndex:0];
        [toolbar setItems:items animated:YES];
        [items release];
        self.popoverController = nil;
}

#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return YES;
}

#pragma mark -
#pragma mark View lifecycle

/*
   // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
   - (void)viewDidLoad {
   [super viewDidLoad];
   }
 */


- (void)viewWillAppear:(BOOL)animated
{
        tracker = [(TrackerPadAppDelegate*)[[UIApplication sharedApplication] delegate] tracker];
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

- (void)viewDidUnload
{
        // Release any retained subviews of the main view.
        // e.g. self.myOutlet = nil;
        self.popoverController = nil;
}

#pragma mark -
#pragma mark Memory management

/*
   - (void)didReceiveMemoryWarning {
   // Releases the view if it doesn't have a superview.
   [super didReceiveMemoryWarning];

   // Release any cached data, images, etc that aren't in use.
   }
 */

- (void)dealloc
{
        [popoverController release];
        [toolbar release];

        [super dealloc];
}

@end
