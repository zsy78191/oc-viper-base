//
//  VB_ STPopupComponent.h
//  viper-base
//
//  Created by 张超 on 2019/9/3.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Component.h"
@import STPopup;

NS_ASSUME_NONNULL_BEGIN

@interface VB_STPopupComponent : VB_Component <VB_ComponentTypePopup_Protocol>
@property (nonatomic, assign) STPopupStyle ststyle;
@property (nonatomic, assign) BOOL navigationBarHidden;
@property (nonatomic, assign) BOOL clickBgClose;
@end

NS_ASSUME_NONNULL_END
