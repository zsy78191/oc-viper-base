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

- (void)presentAlert:(UIAlertController*)alert sender:(id)sender
{
    if (alert.preferredStyle == UIAlertControllerStyleActionSheet) {
        alert.popoverPresentationController.barButtonItem = sender;
        [self.presenter present:alert];
    } else {
        [self.presenter present:alert];
    }
}

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
        [alert setTitle:@"提示"];
        [alert setMessage:msg];
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            adapter(@1,nil);
        }];
        
        [alert addAction:action];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            adapter(@(-1),nil);
        }]];
        [alert setPreferredAction:action];
        [self presentAlert:alert sender:sender];
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
        
        [self presentAlert:alert sender:sender];
        
    }];
    return a;
}

- (AnyPromise *)alert:(NSString *)msg input:(NSString *)placeholder sender:(id)sender
{
    return [self alert:msg input:placeholder input:nil sender:sender];
}

- (AnyPromise *)alert:(NSString *)msg
                input:(NSString *)placeholder
                input:(NSString *)placeholder2
               sender:(id)sender
{
    return [self alert:msg input:placeholder input:placeholder2 config:nil sender:sender];
}

- (AnyPromise *)alert:(NSString *)msg
                input:(NSString *)placeholder
                input:(NSString *)placeholder2
               config:(void (^)(UIAlertController * _Nonnull))config
               sender:(id)sender
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert setTitle:@"请输入"];
        [alert setMessage:msg];
        
        if (placeholder) {
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = placeholder;
            }];
        }
        
        if (placeholder2) {
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = placeholder2;
            }];
        }
        
        __weak UIAlertController* a = alert;
        UIAlertAction* action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSMutableArray* result = [[NSMutableArray alloc] init];
            [a.textFields enumerateObjectsUsingBlock:^(UITextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [result addObject:obj.text];
            }];
            r(result);
        }];
        
        [alert addAction:action];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            r(nil);
        }]];
        [alert setPreferredAction:action];
        if (config) {
           config(alert);
        }
        [self presentAlert:alert sender:sender];
    }];
}


@end
