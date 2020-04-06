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

/// TableView相关事件
@protocol VB_EVENT_Tableview <NSObject>

@optional

- (void)tableViewDidSelect:(PMKResolver)resolver param:(id)param;
- (void)tableViewDidDelete:(PMKResolver)resolver param:(NSIndexPath*)indexPath;
- (void)tableViewDidInsert:(PMKResolver)resolver param:(NSIndexPath*)indexPath;

@end

@interface VB_Interactor : NSObject <VB_EVENT_Tableview>

@property (nonatomic, weak) VB_Interactor* parentInteractor;
@property (nonatomic, weak) VB_Presenter* presenter;


/// 加载组件，对应的Prenseter加载组件时会调用
/// @param component 组件
- (void)setupComponent:(__kindof VB_Component*)component;

#pragma mark - Lifecircle

- (id)preloadData;


#pragma mark - 例子
/// 一个RAC订阅者Selector的声明例子
/// @param subscriber 订阅者
- (void)action:(id<RACSubscriber>)subscriber;


@end

NS_ASSUME_NONNULL_END
