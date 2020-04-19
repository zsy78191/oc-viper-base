//
//  VB_Header.h
//  viper-base
//
//  Created by 张超 on 2019/8/23.
//  Copyright © 2019 orzer. All rights reserved.
//

#ifndef VB_Header_h
#define VB_Header_h

#import <UIKit/UIKit.h>
@import ReactiveObjC;
@import PromiseKit;
@class VB_Component;

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

/// 组件
@protocol VB_USE_Component <NSObject>

@required
/// 加载组件
/// @param component 组件对象
- (void)setupComponent:(__kindof VB_Component*)component;

/// 请继承这个方法加载组件
- (void)loadComponents;

@optional
- (AnyPromise*)setupComponentPromise:(__kindof VB_Component*)component;



@end

#endif /* VB_Header_h */
