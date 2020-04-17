//
//  VB_Picker_Presenter.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/4/1.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Picker_Presenter.h"

@interface VB_Picker_Presenter () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView* picker;
@property (nonatomic, strong) UIDatePicker* datePicker;
@property (nonatomic, strong) PMKResolver resovler;
@property (nonatomic, strong) NSDictionary* attr;
@property (nonatomic, strong) id value;
@end

@implementation VB_Picker_Presenter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.preferredContentSize = CGSizeMake(100, 300);
//    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    self.view.backgroundColor = [UIColor clearColor];
    
    UIBlurEffect *blurForHeadImage = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView* v = [[UIVisualEffectView alloc] initWithEffect:blurForHeadImage];
    [self.view addSubview:v];
    [v setFrame:self.view.bounds];
    [v setAutoresizingMask:0xff];
    
    switch (self.type) {
        case VBPickerTypeNumber:
        {
            self.picker = [[UIPickerView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:self.picker];
            self.picker.dataSource = self;
            self.picker.delegate = self;
            [self selectPicker:self.picker];
            break;
        }
        case VBPickerTypeDate:
        {
            self.datePicker = [[UIDatePicker alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:self.datePicker];
            break;
        }
        case VBPickerTypeArray:
        {
            self.picker = [[UIPickerView alloc] initWithFrame:self.view.bounds];
            [self.view addSubview:self.picker];
            self.picker.dataSource = self;
            self.picker.delegate = self;
            [self selectPicker:self.picker];
            break;
        }
        default:
            break;
    }
    
    self.attr = @{
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    [button setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:button];
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.center = CGPointMake(self.view.center.x, self.view.center.y + self.view.frame.size.height/2 * 0.76);
    [button addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectPicker:(UIPickerView*)picker
{
    if (self.selectedComponent) {
        [picker selectedRowInComponent:self.selectedComponent()];
    }
    if (self.selectedItem) {
        NSInteger c = self.componentCount();
        for (int i = 0; i<c; i++) {
            NSInteger s = self.selectedItem(i);
            NSLog(@"%@",@(s));
            [picker selectRow:s inComponent:i animated:NO];
        }
    }
}

- (VB_Picker_Presenter * _Nonnull (^)(VBPickerType))typed
{
    return ^ (VBPickerType type) {
        self.type = type;
        return self;
    };
}

- (void)ensure
{
    self.resovler(self.value);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (AnyPromise * _Nonnull (^)(__kindof UIViewController * _Nonnull))show
{
    return ^ (__kindof UIViewController* vc) {
        return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
            self.resovler = r;
            self.modalPresentationStyle = UIModalPresentationCustom;
            [vc presentViewController:self animated:YES completion:^{
    
            }];
        }];
    };
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (self.itemCount) {
        return self.itemCount(component);
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.componentCount) {
        return self.componentCount();
    }
    return 0;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.titleBlcok) {
         return [[NSAttributedString alloc] initWithString:self.titleBlcok(component, row) attributes:self.attr];
    }
    return [[NSAttributedString alloc] initWithString:@"" attributes:self.attr];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.value = @(row);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
