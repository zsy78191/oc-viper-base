//
//  UIBarButtonItem+VB.m
//  viper-base
//
//  Created by 张超 on 2019/8/30.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "UIBarButtonItem+VB.h"
#import "VB_Header.h"
@import PromiseKit;
@import ReactiveObjC;

@implementation UIBarButtonItem (VB)

- (void)VB_SetPromise:(id)sender selector:(SEL)selector;
{
    __weak typeof (sender) weakSender = sender;
    self.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
       
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
                if ([weakSender respondsToSelector:selector]) {
                    SuppressPerformSelectorLeakWarning(
                        [weakSender performSelector:selector withObject:r];
                    );
                }
            }].then(^(id d){
                [subscriber sendNext:d];
            }).catch(^(id e){
                [subscriber sendError:e];
            }).ensure(^(){
                [subscriber sendCompleted];
            });
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
}

@end

@implementation UIButton (VB)

- (void)VB_SetPromise:(id)sender selector:(SEL)selector;
{
    __weak typeof (sender) waekSender = sender;
    self.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
                if ([waekSender respondsToSelector:selector]) {
                    SuppressPerformSelectorLeakWarning(
                       [waekSender performSelector:selector withObject:r];
                   );
                }
            }].then(^(id d){
                [subscriber sendNext:d];
            }).catch(^(id e){
                [subscriber sendError:e];
            }).ensure(^(){
                [subscriber sendCompleted];
            });
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
}

@end
