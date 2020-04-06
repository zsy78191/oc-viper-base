//
//  VB_Picker_Presenter.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/4/1.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Presenter.h"
@class AnyPromise;
#import "VB_Picker_Presenter_Header.h"

NS_ASSUME_NONNULL_BEGIN

@interface VB_Picker_Presenter : VB_Presenter

@property (nonatomic, assign) VBPickerType type;
@property (nonatomic, readonly) VB_Picker_Presenter* (^typed)(VBPickerType type);
@property (nonatomic, readonly) AnyPromise* (^show)(__kindof UIViewController* shower);

@property (nonatomic, strong) NSInteger (^componentCount)(void);
@property (nonatomic, strong) NSInteger (^itemCount)(NSInteger component);
@property (nonatomic, strong) NSString* (^titleBlcok)(NSInteger component, NSInteger item);
@property (nonatomic, strong) NSInteger (^selectedComponent)(void);
@property (nonatomic, strong) NSInteger (^selectedItem)(NSInteger component);
@end

NS_ASSUME_NONNULL_END
