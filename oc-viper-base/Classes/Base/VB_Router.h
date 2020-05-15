//
//  VB_Router.h
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <MGJRouter/MGJRouter.h>
@class AnyPromise;

NS_ASSUME_NONNULL_BEGIN

@interface VB_Router : NSObject


/// 获取单例
@property (class, nonatomic) void (^registTransaction)(VB_Router* router);


/// 获取单例的Promise
+ (AnyPromise*)registTransactionPromise;


/// 全局绑定对象
/// @param key 对象key
/// @param entity 对象
+ (AnyPromise*)bind:(NSString*)key entity:(id)entity;

- (void)bind:(NSString*)key entity:(id)entity;


/// 获取全局绑定对象
/// @param key key
+ (id)entityForKey:(NSString*)key;


/// 获取全局绑定对象Promise
/// @param key key
+ (AnyPromise*)globalEntityForKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
