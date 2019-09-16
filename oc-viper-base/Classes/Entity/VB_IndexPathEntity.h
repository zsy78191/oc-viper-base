//
//  VB_IndexPathEntity.h
//  viper-base
//
//  Created by 张超 on 2019/8/28.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface VB_IndexPathEntity : VB_Entity

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* subTitle;
@property (nonatomic, strong) NSString* identifier;

@property (nonatomic, strong) id data;

@property (nonatomic, strong) NSMutableArray <__kindof VB_Entity*>* childrens;

@end

NS_ASSUME_NONNULL_END