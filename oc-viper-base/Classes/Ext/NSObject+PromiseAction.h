//
//  NSObject+PromiseAction.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/23.
//  Copyright © 2020 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACCommand,AnyPromise,RACSignal;

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (PromiseAction)

/// 根据Selector的名称返回给UIButton和UIItemButton用的RACCommond
/// @param name selector名称
- (RACCommand*)commandWithName:(NSString*)name;


/// 根据Selector的名称返回给UIButton和UIItemButton用的RACCommond，附带enable控制信号
/// @param name selector名称
/// @param enableSignal 控制信号
- (RACCommand*)commandWithName:(NSString*)name enableSignal:(RACSignal* _Nullable)enableSignal;

- (RACCommand*)commandWithName:(NSString*)name param:(id _Nullable)param;

- (RACCommand*)commandWithName:(NSString*)name param:(id _Nullable)param enableSignal:(RACSignal* _Nullable)enableSignal;

/// 根据Selector的名称返回Promise
/// @param name selector名称
- (AnyPromise*)promiseWithName:(NSString*)name;

/// 上一个方法的点写法声明
@property (nonatomic, readonly) AnyPromise* (^promise)(NSString*);

/// 根据Selector的名称返回Promise
/// @param name selector名称
/// @param param 参数
- (AnyPromise*)promiseWithName:(NSString*)name param:(id)param;

/// 上一个方法的点写法声明
@property (nonatomic, readonly) AnyPromise* (^paramPromise)(NSString*,id);

@end

NS_ASSUME_NONNULL_END
