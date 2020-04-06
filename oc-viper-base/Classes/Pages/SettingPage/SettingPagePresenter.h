//
//  SettingPagePresenter.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/24.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Presenter.h"
#import "VBSettingEntityProtocal.h"
@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface SettingPagePresenter : VB_Presenter

- (void)setupEntity:(id<VBSettingEntityProtocal>)entity;

@property (nonatomic, strong) Class pickerComponentClass;
@property (nonatomic, assign) BOOL showSystemSetting;

@end

NS_ASSUME_NONNULL_END
