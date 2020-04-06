//
//  SettingItemEntity.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/25.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SettingItemEntity.h"
#import "VB_FormatterManager.h"

@implementation SettingItemEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxNumber = 10;
        self.minNumber = 0;
    }
    return self;
}

- (void)setSubTitle:(NSString *)subTitle
{
    [super setSubTitle:subTitle];
}

- (void)setValue:(id)value
{
    if (!value) {
        _value = value;
        return;
    };
    if (_value) {
        id origin = [_value copy];
        if ([_value isKindOfClass:[NSString class]]) {
            _value = [value description];
            [self setSubtitleWithValue:_value];
        } else if([_value isKindOfClass:[NSNumber class]]) {
            if ([value isKindOfClass:[NSNumber class]]) {
                _value = value;
            } else {
                NSNumberFormatter* f = [self formatter];
                _value = [f numberFromString:[value description]];
            }
            [self setSubtitleWithValue:_value];
        }
        if (!_value) {
            _value = origin;
        }
    } else {
        _value = value;
        [self setSubtitleWithValue:value];
    }
}

- (void)setSubtitleWithValue:(id)value
{
    if (!value) {
        return;
    }
    if ([value isKindOfClass:[NSString class]]) {
        self.subTitle = [value description];
    } else if([value isKindOfClass:[NSNumber class]]) {
        NSNumberFormatter* f = [self formatter];
        self.subTitle = [f stringFromNumber:value];
    }
     
}

- (NSNumberFormatter*)formatter
{
    return self.numberFormatter ? self.numberFormatter : [[VB_FormatterManager sharedManager] numberFormatter];
}


@end
