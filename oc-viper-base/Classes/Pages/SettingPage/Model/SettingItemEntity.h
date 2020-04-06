//
//  SettingItemEntity.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/25.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_IndexPathEntity.h"
#import "VBSettingEntityProtocal.h"

NS_ASSUME_NONNULL_BEGIN


@interface SettingItemEntity : VB_IndexPathEntity
@property (nonatomic, strong) id value;
@property (nonatomic, assign) SettingItemType type;
@property (nonatomic, strong) NSString* keyString;

@property (nonatomic, assign) double maxNumber;
@property (nonatomic, assign) double minNumber;
@property (nonatomic, assign) double step;

@property (nonatomic, strong) NSArray* selections;

@property (nonatomic, strong) NSNumberFormatter* numberFormatter;

@end

NS_ASSUME_NONNULL_END
