//
//  DemoEntityItem.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/23.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Entity.h"
#import "VB_IndexPathEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomCellEntity : VB_IndexPathEntity
@property (nonatomic, strong) NSString* presenterClassName;
@property (nonatomic, strong) NSString* json;
@property (nonatomic, strong) NSString* settingEntity;
@end

NS_ASSUME_NONNULL_END
