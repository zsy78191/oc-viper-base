//
//  VBSettingEntityProtocal.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/25.
//  Copyright © 2020 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ReactiveObjC;

@class SettingItemEntity;

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    SettingItemTypeText,
    SettingItemTypePicker,
    SettingItemTypeSelections,
    SettingItemTypeSwitch,
    SettingItemTypeTitle,
    SettingItemTypeNoUse,
    SettingItemTypeDate,
    SettingItemTypeNumber
} SettingItemType;

@protocol VBSettingEntityProtocal <NSObject>

@required
- (NSString*)titleForKey:(NSString*)key;
- (SettingItemType)typeForKey:(NSString*)key;

@optional
- (NSString*)descriptionForKey:(NSString*)key;
- (NSString*)iconForKey:(NSString*)key;
- (NSString*)identifierForKey:(NSString*)key;

- (void)configItem:(SettingItemEntity*)item;

@property (nonatomic, strong) void (^ changeValueBlock)(id key, id value);

@end

NS_ASSUME_NONNULL_END
