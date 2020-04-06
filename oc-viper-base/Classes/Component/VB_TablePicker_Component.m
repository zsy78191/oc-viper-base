//
//  VB_TablePicker_Component.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/4/3.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_TablePicker_Component.h"
@import PromiseKit;
#import "VB_Picker_Table_Presenter.h"

@implementation VB_TablePicker_Component

- (VB_ComponentType)type
{
    return VB_ComponentTypePicker;
}

- (nonnull AnyPromise *)picker {
    return [self pickerWithArray:@[@"选项1",@"选项2",@"选项3"] selected:0];
}

- (nonnull AnyPromise *)pickerWithArray:(nonnull NSArray<NSString *> *)array {
    return [self pickerWithArray:array selected:0];
}

- (nonnull AnyPromise *)pickerWithArray:(nonnull NSArray<NSString *> *)array selected:(NSInteger)selected {
    VB_Picker_Table_Presenter* picker = [[VB_Picker_Table_Presenter alloc] init];
//    picker.selections = array;
//    picker.selected = selected;
    picker.needData = ^id _Nonnull(NSString * _Nonnull key) {
        if ([key isEqualToString:@"selections"]) {
            return array;
        } else if([key isEqualToString:@"selected"]) {
            return @(selected);
        }
        return nil;
    };
    return picker.typed(VBPickerTypeArray).show(self.presenter);
}

@end
