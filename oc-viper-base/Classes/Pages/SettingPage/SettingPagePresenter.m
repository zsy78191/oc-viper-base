//
//  SettingPagePresenter.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/24.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SettingPagePresenter.h"
#import "VB_Out_Header.h"

@interface SettingPagePresenter ()
@property (nonatomic, strong) VB_TableviewComponent* table;
@property (nonatomic, weak) id<VBSettingEntityProtocal> entity;
@end

@implementation SettingPagePresenter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)loadComponents
{
    [super loadComponents];
    self.table = [[VB_TableviewComponent alloc] init];
    self.table.fullSize = YES;
    [self setupComponent:self.table];
    [self.table registCell:NSClassFromString(@"SettingCellTitle") forIdentifier:@"SettingCellTitle"];
    [self.table registCell:NSClassFromString(@"SettingCellNumber") forIdentifier:@"SettingCellNumber"];
    [self.table registCell:NSClassFromString(@"SettingCellSwitch") forIdentifier:@"SettingCellSwitch"];
    [self.table registCell:NSClassFromString(@"SettingCellDescription") forIdentifier:@"SettingCellDescription"];
    
    VB_AlertComponent* alert = [[VB_AlertComponent alloc] init];
    [self setupComponent:alert];
    
    if (self.showSystemSetting) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"系统设置" style:UIBarButtonItemStylePlain target:self action:@selector(openSetting)];
    }

    if (!self.pickerComponentClass) {
        self.pickerComponentClass = [VB_Picker_Component class];
    }
    id<VB_ComponentTypePicker_Protocol> picker = [[self.pickerComponentClass alloc] init];
    [self setupComponent:picker];
}

- (void)openSetting {
    [VB_Router systemSchemeJumpSelf];
}

- (void)setupEntity:(id<VBSettingEntityProtocal>)entity
{
    [self.interactor promiseWithName:@"setupEntity:" param:entity];
    self.entity = entity;
}

- (id)objectForReturn
{
    return self.entity;
}

- (Class)interactorClass
{
    return NSClassFromString(@"SettingPageInteractor");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc
{
    NSLog(@"[SETTING]%s",__func__);
}

@end
