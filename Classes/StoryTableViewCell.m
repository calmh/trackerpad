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
                self.backgroundView.backgroundColor = [UIColor colorWithRed:0xd8 / 256.0 green:0xee / 256.0 blue:0xcc / 256.0 alpha:1.0];
        else if ([@"started" isEqualToString:state] || [@"finished" isEqualToString:state] || [@"delivered" isEqualToString:state])
                self.backgroundView.backgroundColor = [UIColor colorWithRed:0xff / 256.0 green:0xf8 / 256.0 blue:0xdc / 256.0 alpha:1.0];
        else if ([@"unscheduled" isEqualToString:state])
                self.backgroundView.backgroundColor = [UIColor colorWithRed:0xe7 / 256.0 green:0xf3 / 256.0 blue:0xfa / 256.0 alpha:1.0];
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
}

- (void)dealloc
{
        [super dealloc];
}

@end
