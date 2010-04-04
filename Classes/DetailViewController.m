//
//  DetailViewController.m
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "DetailViewController.h"
#import "IterationViewController.h"
#import "RootViewController.h"
#import "Tracker.h"
#import "TrackerPadAppDelegate.h"
#import "TrackerProject.h"

@interface DetailViewController (Private)

- (void)configureView;
- (IterationViewController*)loadIterationsControllerAtIndex:(NSInteger)index;

@end

@implementation DetailViewController

@synthesize toolbar, popoverController, project;

- (void)setProject:(TrackerProject*)newProject
{
        if (project != newProject) {
                [project release];
                project = [newProject retain];

                [self configureView];
        }

        if (popoverController != nil)
                [popoverController dismissPopoverAnimated:YES];
}

- (void)splitViewController:(UISplitViewController*)svc willHideViewController:(UIViewController*)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController:(UIPopoverController*)pc
{
        barButtonItem.title = @"Root List";
        NSMutableArray *items = [[toolbar items] mutableCopy];
        [items insertObject:barButtonItem atIndex:0];
        [toolbar setItems:items animated:YES];
        [items release];
        self.popoverController = pc;
}

- (void)splitViewController:(UISplitViewController*)svc willShowViewController:(UIViewController*)aViewController invalidatingBarButtonItem:(UIBarButtonItem*)barButtonItem
{
        NSMutableArray *items = [[toolbar items] mutableCopy];
        [items removeObjectAtIndex:0];
        [toolbar setItems:items animated:YES];
        [items release];
        self.popoverController = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return YES;
}

- (void)viewDidLoad
{
        [super viewDidLoad];
        delegate = [[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated
{
        tracker = [(TrackerPadAppDelegate*)[[UIApplication sharedApplication] delegate] tracker];
        [super viewWillAppear:animated];
}

- (void)viewDidUnload
{
        self.popoverController = nil;
}

- (void)dealloc
{
        [popoverController release];
        [toolbar release];

        [super dealloc];
}

// Private methods below

- (void)configureView
{
        if (leftController != nil) {
                [leftController.containerView removeFromSuperview];
                [leftController release];

                [rightController.containerView removeFromSuperview];
                [rightController release];
        }

        NSArray *iterations = [NSArray arrayWithObject:[tracker currentIterationInProject:project.id]];
        leftController = [self loadIterationsControllerAtIndex:0];

        iterations = [tracker backlogIterationsInProject:project.id];
        rightController = [self loadIterationsControllerAtIndex:1];
}

- (IterationViewController*)loadIterationsControllerAtIndex:(NSInteger)index
{
        IterationViewController *controller = [[IterationViewController alloc] initWithNibName:@"IterationView" bundle:[NSBundle mainBundle]];
        controller.view;
        CGRect detailFrame = [self.view frame];
        controller.containerView.frame = CGRectMake(index * 350.0,
                                                    0.0,
                                                    detailFrame.size.width / 2,
                                                    detailFrame.size.height);
        [self.view addSubview:controller.containerView];
        controller.project = project;
        controller.index = index;

        IterationEnum storedState = [delegate defaultStateForProject:project.id andPane:index];
        [controller setIteration:storedState];

        return controller;
}

@end
