//
//  VB_Presenter+DataTrans.m
//  ViperDevelopment
//
//  Created by 张超 on 2019/11/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Presenter+DataTrans.h"
@import PromiseKit;

@implementation VB_Presenter (DataTrans)

@dynamic loadData, getData;

- (AnyPromise * _Nonnull (^)(NSString * _Nonnull))loadData
{
    __weak typeof(self) ws = self;
    return ^ (NSString* key) {
        RACSignal* c = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                     if (ws.needLoadData) {
                         ws.needLoadData(key, subscriber);
                     }
                     return [RACDisposable disposableWithBlock:^{
                         
                     }];
        }];
        return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
            [c subscribeNext:^(id  _Nullable x) {
                r(x);
            } error:^(NSError * _Nullable error) {
                r(error);
            } completed:^{
                
            }];
        }];
    };
}


- (id (^)(NSString * _Nonnull))getData
{
    return ^ (NSString* key) {
        return self.needData(key);
    };
}

@end
