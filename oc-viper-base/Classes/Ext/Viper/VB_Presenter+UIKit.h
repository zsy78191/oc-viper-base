//
//  VB_Presenter+UIKit.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/24.
//  Copyright © 2020 orzer. All rights reserved.
//
 
#import "VB_Presenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface VB_Presenter (UIKit)

- (BOOL)isSearchViewControllerResult;
- (VB_Presenter* _Nullable)parentPresenter;
//- (void)closePresenter;
- (AnyPromise *)show:(__kindof UIViewController *)viewController;
- (AnyPromise *)show:(__kindof UIViewController *)viewController model:(UIModalPresentationStyle)style;
- (AnyPromise *)show:(__kindof UIViewController *)viewController model:(UIModalPresentationStyle)style usePush:(BOOL)usePush;
@end

NS_ASSUME_NONNULL_END
