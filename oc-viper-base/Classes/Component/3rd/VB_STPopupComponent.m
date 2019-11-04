//
//  VB_ STPopupComponent.m
//  viper-base
//
//  Created by 张超 on 2019/9/3.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_STPopupComponent.h"
#import "VB_Presenter.h"
@import PromiseKit;
@import ReactiveObjC;
@interface VB_STPopupComponent ()
{
    
}
@property (nonatomic, weak) STPopupController* currentPopup;
@end

@implementation VB_STPopupComponent

@synthesize style = _style;
@synthesize navigationBarHidden, clickBgClose, toolBarHidden;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = STPopupStyleFormSheet;
        self.navigationBarHidden = YES;
        self.toolBarHidden = YES;
        self.clickBgClose = YES;
    }
    return self;
}

- (void)setStyle:(VBPopupType)style
{
    _style = style;
    switch (style) {
        case VBPopupTypeForm:
            self.ststyle = STPopupStyleFormSheet;
            break;
        case VBPopupTypeBottom:
            self.ststyle = STPopupStyleBottomSheet;
            break;
        default:
            break;
    }
}

- (void)popup:(__kindof UIViewController *)vc
{
    [self popup:vc completion:nil];
}

- (void)popup:(__kindof UIViewController *)vc completion:(void (^)(void))completion
{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:nil action:nil];
    vc.navigationItem.leftBarButtonItem = item;
    
    
    if ((!self.navigationBarHidden || !self.toolBarHidden) && ![vc isKindOfClass:[UINavigationController class]]) {
        id target = vc;
        vc = [[UINavigationController alloc] initWithRootViewController:target];
        
        UINavigationController* nv = vc;
        [nv setNavigationBarHidden:self.navigationBarHidden];
        [nv setToolbarHidden:self.toolBarHidden];
    }
    
    CGFloat margin = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad? 120 : 30;
    CGFloat margin_top =  [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad? 0 : 30;
    vc.contentSizeInPopup = CGSizeMake([self.presenter view].frame.size.width - margin, [self.presenter view].frame.size.height - margin - margin_top*2);
    vc.landscapeContentSizeInPopup = CGSizeMake([self.presenter view].frame.size.width - margin, [self.presenter view].frame.size.height - margin - margin_top*2);
//    NSLog(@"$…………");
    
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:vc];
    self.currentPopup = popupController;
    popupController.hidesCloseButton = NO;
    popupController.style = self.ststyle;
    popupController.navigationBarHidden = self.navigationBarHidden;
    [popupController presentInViewController:(id)self.presenter completion:completion];
    
    popupController.containerView.layer.cornerRadius = 10;
    __weak typeof(popupController) weak_popupController = popupController;
    
    if (self.clickBgClose) {
        [popupController.backgroundView addGestureRecognizer:({
            UITapGestureRecognizer* t = [[UITapGestureRecognizer alloc] initWithTarget:nil action:nil];
            [[t rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
                if (x.state == UIGestureRecognizerStateEnded) {
                    [weak_popupController dismiss];
                }
            }];
            t;
        })];
    }
    
    
    item.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [weak_popupController dismiss];
            [subscriber sendCompleted];
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
}

- (void)popdown
{
    [self popdown:nil];
}

- (void)popdown:(void (^)(void))completion
{
    if (self.currentPopup) {
        [self.currentPopup dismissWithCompletion:completion];
    }
}

- (AnyPromise *)popupPromise:(__kindof UIViewController *)vc
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        [self popup:vc completion:^{
            r(@1);
        }];
    }];
}

- (AnyPromise *)popdownPromise
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        [self popdown:^{
            r(@1);
        }];
    }];
}

- (VB_ComponentType)type
{
    return VB_ComponentTypePopup;
}

@end
