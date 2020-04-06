//
//  DemoSettingEntity.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/25.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SettingEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface DemoSettingEntity : SettingEntity

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSNumber* count;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSNumber* saved;
@property (nonatomic, strong) NSString* state;

@end

NS_ASSUME_NONNULL_END
