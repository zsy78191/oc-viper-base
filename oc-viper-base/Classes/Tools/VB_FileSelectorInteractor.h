//
//  DemoInteractorSix.h
//  viper-base
//
//  Created by 张超 on 2019/9/9.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Interactor.h"
@protocol RACSubscriber;
@import PromiseKit;
NS_ASSUME_NONNULL_BEGIN

@interface VB_FileSelectorInteractor : VB_Interactor

- (AnyPromise*)selectFileWithUTIs:(NSArray<NSString*>*)utis;
- (AnyPromise*)selectFileWithUTIs:(NSArray<NSString*>*)utis viewController:(__kindof UIViewController*)presenter;

#pragma mark - DEPRECATED

- (void)selectFont:(id<RACSubscriber>)subscriber param:(id)type __attribute__((unavailable("使用 selectFileWithUTIs:")));
@property (nonatomic, strong) void (^ finishBlock)(NSString* file, id<RACSubscriber> subscriber) __attribute__((unavailable("接口废弃")));
@end

NS_ASSUME_NONNULL_END
