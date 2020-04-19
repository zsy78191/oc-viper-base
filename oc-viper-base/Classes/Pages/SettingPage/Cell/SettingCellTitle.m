//
//  SettingCellTitle.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/25.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SettingCellTitle.h"
#import "SettingItemEntity.h"
@import ReactiveObjC;

@implementation SettingCellTitle

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)loadData:(SettingItemEntity*)data
{
    
    RAC(self.detailTextLabel, text) = [RACObserve(data, detial) takeUntil:[self rac_prepareForReuseSignal]];
}

@end
