//
//  SettingCellSwitch.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/30.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SettingCellSwitch.h"
#import "SettingItemEntity.h"
@import ReactiveObjC;

@interface SettingCellSwitch ()
@property (weak, nonatomic) IBOutlet UISwitch *switcher;

@end

@implementation SettingCellSwitch

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
//    NSLog(@"-- %@",data.value);
    [self.switcher setOn:[data.value boolValue]];
    [[RACKVOChannel alloc] initWithTarget:data keyPath:@"value" nilValue:data.value][@keypath(RACKVOChannel.new, followingTerminal)] =  [self.switcher rac_newOnChannel];
}


@end
