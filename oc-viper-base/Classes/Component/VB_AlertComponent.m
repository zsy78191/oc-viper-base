//
//  VB_AlertComponent.m
//  viper-base
//
//  Created by 张超 on 2019/8/29.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_AlertComponent.h"
#import "VB_Presenter.h"
@import PromiseKit;
@import ReactiveObjC;

@implementation VB_AlertComponent

- (VB_ComponentType)type
{
    return VB_ComponentTypeAlert;
}

- (AnyPromise *)alert:(NSString *)msg sender:(id)sender
{
    @weakify(self);
    AnyPromise* a = [AnyPromise promiseWithAdapterBlock:^(PMKAdapter  _Nonnull adapter) {
        @strongify(self);
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert setTitle:@"1"];
        [alert setMessage:@"2"];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"321" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            adapter(@1,nil);
        }];
        
        [alert addAction:action];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            adapter(@(-1),nil);
        }]];
        [alert setPreferredAction:action];
        [self.presenter present:alert];
    }];
    return  a;
}


- (AnyPromise *)alert:(UIAlertControllerStyle)style
           selections:(NSArray<NSString *> *)selections
               config:(void (^)(UIAlertController * _Nonnull))config
               sender:(id _Nullable)sender
{
    @weakify(self);
    AnyPromise* a = [AnyPromise promiseWithAdapterBlock:^(PMKAdapter  _Nonnull adapter) {
        @strongify(self);
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:style];
        [selections enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIAlertAction* ac = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                adapter(@(idx),nil);
            }];
            [alert addAction:ac];
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            adapter(@(-1),nil);
        }]];
        if (config) {
            config(alert);
        }
        if (style == UIAlertControllerStyleActionSheet) {
            alert.popoverPresentationController.barButtonItem = sender;
            [self.presenter present:alert];
        } else {
            [self.presenter present:alert];
        }
    }];
    return a;
}


@end
