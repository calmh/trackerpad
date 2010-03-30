//
//  IterationViewController.h
//  TrackerPad
//
//  Created by Jakob Borg on 3/30/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "TrackerIteration.h"
#import <UIKit/UIKit.h>

@interface IterationViewController : UITableViewController {
        NSArray *iterations;
}

@property (nonatomic, retain) NSArray *iterations;

@end
