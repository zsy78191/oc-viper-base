//
//  SettingCellNumber.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/30.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SettingCellNumber.h"
#import "SettingItemEntity.h"
@import ReactiveObjC;

@interface SettingCellNumber ()
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@end

@implementation SettingCellNumber

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
    RAC(data,value) = [[self.stepper rac_newValueChannelWithNilValue:data.value] takeUntil:[self rac_prepareForReuseSignal]];
    RAC(self.numLabel, text) = [RACObserve(data, detial) takeUntil:[self rac_prepareForReuseSignal]];
    
    self.stepper.maximumValue = data.maxNumber;
    self.stepper.minimumValue = data.minNumber;
    self.stepper.stepValue = data.step;
    self.stepper.value = [data.value doubleValue];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
