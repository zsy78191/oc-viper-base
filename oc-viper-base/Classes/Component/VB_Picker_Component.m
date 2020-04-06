//
//  VB_Picker_Component.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/4/1.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Picker_Component.h"
#import "VB_Picker_Presenter.h"
@import PromiseKit;

@implementation VB_Picker_Component

- (VB_ComponentType)type
{
    return VB_ComponentTypePicker;
}

- (AnyPromise *)picker
{
    VB_Picker_Presenter* picker = [[VB_Picker_Presenter alloc] init];
    return picker.typed(VBPickerTypeNumber)
    .show(self.presenter);
}

- (AnyPromise *)pickerWithArray:(NSArray *)array
{
    return [self pickerWithArray:array selected:0];
}

- (AnyPromise *)pickerWithArray:(NSArray<NSString *> *)array selected:(NSInteger)selected
{
    VB_Picker_Presenter* picker = [[VB_Picker_Presenter alloc] init];
    picker.componentCount = ^NSInteger{
        return 1;
    };
    picker.itemCount = ^NSInteger(NSInteger component) {
        return array.count;
    };
    picker.titleBlcok = ^NSString * _Nonnull(NSInteger component, NSInteger item) {
        return [array objectAtIndex:item];
    };
    picker.selectedComponent = ^NSInteger{
        return 0;
    };
    picker.selectedItem = ^NSInteger(NSInteger component) {
        return selected;
    };
    return picker.typed(VBPickerTypeArray)
      .show(self.presenter);
}

@end
