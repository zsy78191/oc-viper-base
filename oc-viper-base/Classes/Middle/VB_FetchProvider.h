//
//  VB_FetchProvider.h
//  viper-base
//
//  Created by 张超 on 2019/9/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_DataProvider.h"

NS_ASSUME_NONNULL_BEGIN

@class NSManagedObject;
@interface VB_FetchProvider : VB_DataProvider {
    
}

- (instancetype)initWithEntityClass:(Class)entityClass;

@property (nonatomic, strong, readonly) NSString* className;
@property (nonatomic, weak, readonly) UITableView* tableView;


/// 数据实例和list展示的实例，需要通过这个方法转换，这个方法需要子类实现
/// @param entity 原始entity
- (VB_IndexPathEntity*)entityWithOrigin:(id)entity;

- (void)configBeforeInsertToDatabase:(__kindof NSManagedObject*)obj;

/// 默认是VB_IndexPathEntity，可以继承后改写。
- (Class)indexPathEntityClass;

- (nullable NSString*)groupBy;

@end

NS_ASSUME_NONNULL_END
