//
//  VB_FormatterManager.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/27.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_FormatterManager.h"

@implementation VB_FormatterManager

+ (instancetype)sharedManager
{
    static VB_FormatterManager* _shared_formatter_manager_g = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared_formatter_manager_g = [[VB_FormatterManager alloc] init];
    });
    return _shared_formatter_manager_g;
}

- (NSNumberFormatter *)numberFormatter
{
    if (!_numberFormatter) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        [_numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    }
    return _numberFormatter;
}

@end
