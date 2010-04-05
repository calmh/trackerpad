//
//  DetailViewController.m
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "DetailViewController.h"
#import "IterationViewController.h"
#import "PTProject.h"
#import "RootViewController.h"
#import "TrackerClient.h"
#import "TrackerPadAppDelegate.h"

@interface DetailViewController (Private)

- (void)configureView;

@end

@implementation DetailViewController

@synthesize toolbar, popoverController, project;
@synthesize leftController, rightController;
@synthesize leftView, rightView;
@synthesize leftSelector, rightSelector;

- (void)setProject:(PTProject*)newProject
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
        barButtonItem.title = @"Projects";
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
        [leftView addSubview:leftController.view];
        leftController.index = 0;
        [rightView addSubview:rightController.view];
        rightController.index = 1;
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
        self.leftController.project = project;
        self.rightController.project = project;

        IterationEnum storedState = [delegate defaultStateForProject:project.id andPane:0];
        [self.leftController setIteration:storedState];
        storedState = [delegate defaultStateForProject:project.id andPane:1];
        [self.rightController setIteration:storedState];
}

@end
