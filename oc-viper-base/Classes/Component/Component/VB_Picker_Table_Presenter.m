//
//  VB_Picker_Table_Presenter.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/4/3.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Picker_Table_Presenter.h"
#import "VB_Out_Header.h"
@interface VB_Picker_Table_Presenter ()
@property (nonatomic, strong) VB_TableviewComponent* tableComponent;
@property (nonatomic, strong) PMKResolver resovler;
@end

@implementation VB_Picker_Table_Presenter

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id)ensere:(PMKResolver)resolver param:(id)param {
    self.resovler(param);
    [self pop];
    return @YES;
}

- (void)loadComponents
{
    [super loadComponents];
    
    self.tableComponent = [[VB_TableviewComponent alloc] init];
    self.tableComponent.fullSize = YES;
    [self setupComponent:self.tableComponent];
    [self.tableComponent registCell:NSClassFromString(@"DemoMainListCell") forIdentifier:@"MainCell"];
    
    self.title = self.needDataDef(@"title", @"请选择");
}

- (VB_Picker_Table_Presenter * _Nonnull (^)(VBPickerType))typed
{
    return ^ (VBPickerType type) {
        self.type = type;
        return self;
    };
}


- (AnyPromise * _Nonnull (^)(__kindof UIViewController * _Nonnull))show
{
    return ^ (__kindof UIViewController* vc) {
        return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
            self.resovler = r;
//            self.modalPresentationStyle = UIModalPresentationCustom;
            [[vc navigationController] pushViewController:self animated:YES];
        }];
    };
}

- (Class)interactorClass
{
    return NSClassFromString(@"VB_Picker_Table_Interactor");
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
