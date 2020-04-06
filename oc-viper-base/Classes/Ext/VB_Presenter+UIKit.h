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

@end

NS_ASSUME_NONNULL_END
