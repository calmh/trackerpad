//
//  StortyTableViewCell.h
//  TrackerPad
//
//  Created by Jakob Borg on 4/2/10.
//  Copyright 2010 Jakob Borg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoryTableViewCell : UITableViewCell {
        UILabel *textLabel;
        UILabel *ownerLabel;
        UIImageView *typeImageView;
        UIImageView *pointsImageView;
        UIView *backgroundView;
}

@property (nonatomic, retain) IBOutlet UILabel *textLabel;
@property (nonatomic, retain) IBOutlet UILabel *ownerLabel;
@property (nonatomic, retain) IBOutlet UIImageView *typeImageView;
@property (nonatomic, retain) IBOutlet UIImageView *pointsImageView;
@property (nonatomic, retain) IBOutlet UIView *backgroundView;

- (void)setType:(NSString*)type;
- (void)setState:(NSString*)state;
- (void)setPoints:(NSInteger)points;

@end
