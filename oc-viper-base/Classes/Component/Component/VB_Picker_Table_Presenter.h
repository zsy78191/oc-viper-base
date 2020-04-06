//
//  VB_Picker_Table_Presenter.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/4/3.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Presenter.h"
#import "VB_Picker_Presenter_Header.h"
NS_ASSUME_NONNULL_BEGIN

@interface VB_Picker_Table_Presenter : VB_Presenter

@property (nonatomic, assign) VBPickerType type;
@property (nonatomic, readonly) VB_Picker_Table_Presenter* (^typed)(VBPickerType type);
@property (nonatomic, readonly) AnyPromise* (^show)(__kindof UIViewController* shower);

//@property (nonatomic, strong) NSArray* selections;
//@property (nonatomic, assign) NSInteger selected;
@end

NS_ASSUME_NONNULL_END
