//
//  DemoSettingEntity.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/25.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "DemoSettingEntity.h"

@implementation DemoSettingEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.state = @"暂停";
    }
    return self;
}

- (NSDictionary *)dictForTitle
{
    return @{
        @"title": @"标题",
        @"count": @"次数",
        @"password": @"密码",
        @"saved" : @"是否存储",
        @"state" : @"状态"
    };
}

- (NSDictionary *)dictForDescription
{
    return @{
        @"count": @"次数",
        @"password": @"密码",
        @"saved" : @"是否存储",
        @"state" : @"状态"
    };
}

- (NSDictionary *)dictForUserDefaultIndentifer
{
    return @{@"title":@"xxx_preference", @"count": @"count_preference", @"saved": @"xxx_switch", @"state": @"xxx_state"};
}

- (SettingItemType)typeForKey:(NSString*) key {
    if ([key isEqualToString:@"count"]) {
        return SettingItemTypeNumber;
    } else if([key isEqualToString:@"saved"]) {
        return SettingItemTypeSwitch;
    } else if([key isEqualToString:@"state"]) {
        return SettingItemTypePicker;
    }
    return SettingItemTypeText;
}

- (void)configItem:(SettingItemEntity *)item
{
    if ([[item keyString] isEqualToString:@"state"]) {
        item.selections = @[@"开始",@"结束",@"暂停"];
    } else if([[item keyString] isEqualToString:@"count"]) {
        item.maxNumber = 10;
        item.minNumber = -10;
        item.step = 0.5;
        item.numberFormatter = [[NSNumberFormatter alloc] init];
        item.numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        item.numberFormatter.minimumFractionDigits = 3;
    }
}

- (void)dealloc
{
    NSLog(@"[Entity]%s",__func__);
}

@end
