//
//  SettingEntity.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/25.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Entity.h"
#import "VBSettingEntityProtocal.h"
#import "SettingItemEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingEntity : VB_Entity <VBSettingEntityProtocal>

- (NSDictionary*)dictForTitle;
- (NSDictionary*)dictForDescription;
- (NSDictionary*)dictForIcon;
- (NSDictionary*)dictForUserDefaultIndentifer;


@end

NS_ASSUME_NONNULL_END
