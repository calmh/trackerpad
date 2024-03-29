//
//  RootViewController.m
//  Untitled
//
//  Created by Jakob Borg on 3/29/10.
//  Copyright Jakob Borg 2010. All rights reserved.
//

#import "DetailViewController.h"
#import "PTProject.h"
#import "RootViewController.h"
#import "TrackerClient.h"
#import "TrackerPadAppDelegate.h"

@implementation RootViewController

@synthesize detailViewController;

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
        [super viewDidLoad];
        NSLog(@"RootViewController viewDidLoad");
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        delegate = [[UIApplication sharedApplication] delegate];
}

- (void)viewWillAppear:(BOOL)animated
{
        [super viewWillAppear:animated];
        NSLog(@"RootViewController viewWillAppear");
        [self.tableView reloadData];
        NSInteger selectedRow = delegate.currentProjectIndex;
        NSIndexPath *path = [NSIndexPath indexPathForRow:selectedRow inSection:0];
        [self.tableView selectRowAtIndexPath:path animated:animated scrollPosition:UITableViewScrollPositionTop];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)aTableView
{
        return 1;
}

- (NSInteger)tableView:(UITableView*)aTableView numberOfRowsInSection:(NSInteger)section
{
        NSInteger num_projects = [delegate.projects count];
        return num_projects;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
        NSString *cellIdentifier;
        UITableViewCell *cell;

        cellIdentifier = @"ProjectCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil)
                cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] autorelease];

        cell.textLabel.text = [(PTProject*)[delegate.projects objectAtIndex:indexPath.row] name];
        return cell;
}

- (void)tableView:(UITableView*)aTableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
        NSInteger selectedRow = indexPath.row;
        delegate.currentProjectIndex = selectedRow;
        [detailViewController reload];
}

- (void)didReceiveMemoryWarning
{
        [super didReceiveMemoryWarning];
}

- (void)dealloc
{
        [detailViewController release];
        [super dealloc];
}

@end
