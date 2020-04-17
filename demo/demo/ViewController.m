//
//  ViewController.m
//  demo
//
//  Created by 张超 on 2020/4/6.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "ViewController.h"
#import "VB_Out_Header.h"
#import "SystemFontToolPresenter.h"
#import "SettingPagePresenter.h"
#import "MySetting.h"
#import "DemoSettingEntity.h"
@interface ViewController ()
@property (nonatomic, strong) MySetting* setting;
@property (nonatomic, strong) DemoSettingEntity* entity;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)openFont:(id)sender {
    SystemFontToolPresenter* p = [[SystemFontToolPresenter alloc] init];
    p.needData = ^id _Nonnull(NSString * _Nonnull key) {
        if ([key isEqualToString:@"title"]) {
            return @"选择字体";
        }
        return nil;
    };
    [p show:self].then(^(id d) {
        NSLog(@"%@",d);
        [self closePresenter];
    });
}

- (MySetting *)setting
{
    if (!_setting) {
        _setting = [[MySetting alloc] init];
    }
    return _setting;
}

- (DemoSettingEntity *)entity
{
    if (!_entity) {
        _entity = [[DemoSettingEntity alloc] init];
    }
    return _entity;
}

- (IBAction)openSetting:(id)sender {
    SettingPagePresenter* s = [[SettingPagePresenter alloc] init];
//    [s setupEntity:self.entity];
    s.preferredContentSize = CGSizeMake(300, 600);
    [s setPickerComponentClass:[VB_TablePicker_Component class]];
    [s setupEntity:self.entity];
    [s show:self model:UIModalPresentationFormSheet].then(^(id x) {
        NSLog(@"%@",x);
        [self closePresenter];
    });
}


@end
