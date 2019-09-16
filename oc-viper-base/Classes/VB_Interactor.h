//
//  VB_Interactor.h
//  viper-base
//
//  Created by 张超 on 2019/8/23.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Header.h"

NS_ASSUME_NONNULL_BEGIN
@class VB_Presenter;
@class VB_Component;

@protocol VB_EVENT_Tableview <NSObject>

@optional


/**
 内置的tableview选择相应事件

 @param resolver 返回函数
 @param param 参数，一般为indexPath
 */
- (void)tableViewDidSelect:(PMKResolver)resolver param:(id)param;

- (void)tableViewDidDelete:(PMKResolver)resolver param:(NSIndexPath*)indexPath;
- (void)tableViewDidInsert:(PMKResolver)resolver param:(NSIndexPath*)indexPath;

@end

@interface VB_Interactor : NSObject <VB_EVENT_Tableview>

@property (nonatomic, weak) VB_Interactor* parentInteractor;

@property (nonatomic, weak) VB_Presenter* presenter;

- (id)entityForKey:(NSString*)key;

/**
 根据Selector的名称返回给UIButton和UIItemButton用的RACCommond

 @param name selector的名称
 @return RACCommond
 */
- (RACCommand*)commandWithName:(NSString*)name;
- (RACCommand*)commandWithName:(NSString*)name enableSignal:(RACSignal* _Nullable)enableSignal;
- (RACCommand*)commandWithName:(NSString*)name param:(id _Nullable)param;
- (RACCommand*)commandWithName:(NSString*)name param:(id _Nullable)param enableSignal:(RACSignal* _Nullable)enableSignal;
/**
 根据Selector的名称返回Promise

 @param name selector的名称
 @return Promise
 */
- (AnyPromise*)promiseWithName:(NSString*)name;

@property (nonatomic, readonly) AnyPromise* (^promise)(NSString*);

- (AnyPromise*)promiseWithName:(NSString*)name param:(id)param;

@property (nonatomic, readonly) AnyPromise* (^paramPromise)(NSString*,id);

- (void)setupComponent:(__kindof VB_Component*)component;

- (void)dataWithKey:(NSString*)key getter:(void (^)(id data))getter;
- (AnyPromise*)dataWithKey:(NSString*)key;

- (void)callback:(id)data;

#pragma mark - vb_demo

- (void)action:(id<RACSubscriber>)subscriber;

@end

NS_ASSUME_NONNULL_END
