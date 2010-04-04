//
//  StortyTableViewCell.m
//  TrackerPad
//
//  Created by Jakob Borg on 4/2/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import "StoryTableViewCell.h"

@implementation StoryTableViewCell

@synthesize textLabel;
@synthesize ownerLabel;
@synthesize typeImageView;
@synthesize pointsImageView;
@synthesize backgroundView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier
{
        if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
                // Initialization code
        }
        return self;
}

- (void)setType:(NSString*)type
{
        typeImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_icon.png", type]];
}

- (void)setState:(NSString*)state
{
        if ([@"accepted" isEqualToString:state])
                self.backgroundView.backgroundColor = [UIColor colorWithRed:0.9 green:1.0 blue:0.9 alpha:1.0];
        else if ([@"started" isEqualToString:state] || [@"finished" isEqualToString:state] || [@"delivered" isEqualToString:state])
                self.backgroundView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0];
        else if ([@"unscheduled" isEqualToString:state])
                self.backgroundView.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:1.0 alpha:1.0];
        else
                self.backgroundView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

- (void)setPoints:(NSInteger)points
{
        pointsImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%dpt_small.gif", points]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
        [super setSelected:selected animated:animated];

        // Configure the view for the selected state
}

- (void)dealloc
{
        [super dealloc];
}

@end
