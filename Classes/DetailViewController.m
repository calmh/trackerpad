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

@implementation DetailViewController

@synthesize toolbar, popoverController;
@synthesize leftController, rightController;
@synthesize leftView, rightView;
@synthesize leftSelector, rightSelector;

- (void)reload
{
        self.leftController.project = delegate.currentProject;
        self.rightController.project = delegate.currentProject;

        IterationEnum storedState = [delegate defaultStateForProject:delegate.currentProject.id andPane:0];
        [self.leftController setIteration:storedState];
        storedState = [delegate defaultStateForProject:delegate.currentProject.id andPane:1];
        [self.rightController setIteration:storedState];

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
        NSLog(@"DetailViewController viewDidLoad");
        delegate = [[UIApplication sharedApplication] delegate];

        [leftView addSubview:leftController.view];
        leftController.index = 0;
        [rightView addSubview:rightController.view];
        rightController.index = 1;
}

- (void)viewWillAppear:(BOOL)animated
{
        [super viewWillAppear:animated];
        NSLog(@"DetailViewController viewWillAppear");
        [self reload];
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

@end
