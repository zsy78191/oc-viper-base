
//
//  DemoMainListCell.m
//  viper-base
//
//  Created by 张超 on 2019/8/29.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "DemoMainListCell.h"
//@import Classy;
#import "VB_IndexPathEntity.h"

@implementation DemoMainListCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)loadData:(VB_IndexPathEntity*)entity
{
    if (entity.icon) {
        UIImage * image = [UIImage systemImageNamed:entity.icon];
        if (!image) {
            image = [UIImage imageNamed:entity.icon];
        }
        self.imageView.image = image;
    }
    
    if ([self.reuseIdentifier isEqualToString:@"FontCell"]) {
        UIFont* f = [UIFont fontWithName:entity.title size:17];
        if (f) {
            self.textLabel.font = f;
        } else {
            NSString* f = [[UIFont fontNamesForFamilyName:entity.title] firstObject];
            self.textLabel.font = [UIFont fontWithName:f size: 17];
        }
    } else if([self.reuseIdentifier isEqualToString:@"FontChildCell"]){
        UIFont* f = [UIFont fontWithName:entity.title size:17];
        self.textLabel.font = f;
    }
}


@end
