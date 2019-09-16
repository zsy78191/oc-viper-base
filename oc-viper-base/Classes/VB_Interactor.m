//
//  VB_Interactor.m
//  viper-base
//
//  Created by 张超 on 2019/8/23.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Interactor.h"
#import "VB_Component.h"
#import "VB_Presenter.h"

@implementation VB_Interactor

- (id)entityForKey:(NSString *)key
{
    return [self valueForKeyPath:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (RACCommand *)commandWithName:(NSString *)name param:(id _Nullable)param enableSignal:(nullable RACSignal *)enableSignal
{
    @weakify(self);
    return [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            
            NSString* method = [name hasSuffix:@":"]?name:[name stringByAppendingString:@":"];
            NSString* method0 = [method stringByAppendingString:@"sender:"];
            NSString* method1 = [method stringByAppendingString:@"param:"];
            if (param && [self respondsToSelector:NSSelectorFromString(method1)]) {
                SuppressPerformSelectorLeakWarning(
                                                   [self performSelector:NSSelectorFromString(method1) withObject:subscriber withObject:param];
                                                   );
            } else if ([self respondsToSelector:NSSelectorFromString(method0)]) {
                SuppressPerformSelectorLeakWarning(
                                                   [self performSelector:NSSelectorFromString(method0) withObject:subscriber withObject:input];
                                                   );
            } else if ([self respondsToSelector:NSSelectorFromString(method)]) {
                SuppressPerformSelectorLeakWarning(
                                                   [self performSelector:NSSelectorFromString(method) withObject:subscriber];
                                                   );
            } else {
                [subscriber sendError:nil];
                [subscriber sendCompleted];
            }
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
}

- (RACCommand *)commandWithName:(NSString *)name
{
    return [self commandWithName:name param:nil];
}

- (RACCommand *)commandWithName:(NSString *)name enableSignal:(nullable RACSignal *)enableSignal
{
    return [self commandWithName:name param:nil enableSignal:enableSignal];
}

- (RACCommand *)commandWithName:(NSString *)name param:(id)param
{
    return [self commandWithName:name param:param enableSignal:nil];
}


- (AnyPromise *)promiseWithName:(NSString *)name
{
    @weakify(self);
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        @strongify(self);
        NSString* method = [name hasSuffix:@":"]?name:[name stringByAppendingString:@":"];
        if ([self respondsToSelector:NSSelectorFromString(name)]) {
            SuppressPerformSelectorLeakWarning(
                id data = [self performSelector:NSSelectorFromString(name) withObject:nil];
                r(data?data:[NSError errorWithDomain:@"VBErrorDomain" code:203 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"%@.%@属性为nil",self,name]}]);
            );
        } else if ([self respondsToSelector:NSSelectorFromString(method)]) {
            SuppressPerformSelectorLeakWarning(
                [self performSelector:NSSelectorFromString(method) withObject:r];
            );
        } else {
            r([NSError errorWithDomain:NSCocoaErrorDomain code:999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"promise %@没有实现",method]}]);
        }
    }];
}

- (AnyPromise *)promiseWithName:(NSString *)name param:(id)param
{
    @weakify(self);
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        @strongify(self);
        NSString* method = [name hasSuffix:@":"]?name:[name stringByAppendingString:@":"];
        if (![method hasSuffix:@"param:"]) {
            method = [method stringByAppendingString:@"param:"];
        }
        if ([self respondsToSelector:NSSelectorFromString(method)]) {
            SuppressPerformSelectorLeakWarning(
                                               [self performSelector:NSSelectorFromString(method) withObject:r withObject:param];
                                               );
        } else {
            r([NSError errorWithDomain:NSCocoaErrorDomain code:999 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"promise %@没有实现",method]}]);
        }
    }];
}

- (AnyPromise * _Nonnull (^)(NSString * _Nonnull))promise
{
    return ^ (NSString* name) {
        return [self promiseWithName:name];
    };
}

- (AnyPromise * _Nonnull (^)(NSString * _Nonnull, id param))paramPromise
{
    return ^ (NSString* name,  id param) {
        return [self promiseWithName:name param:param];
    };
}

- (void)setupComponent:(__kindof VB_Component *)component
{
    
}

- (VB_Presenter *)presenter
{
    if (!_presenter && self.parentInteractor) {
        return [self.parentInteractor presenter];
    }
    return _presenter;
}

- (void)dealloc
{
    NSLog(@"** %@ %s",[self class],__func__);
}

- (void)dataWithKey:(NSString *)key getter:(void (^)(id _Nonnull))getter
{
    if (self.presenter) {
        [self.presenter dataWithKey:key getter:getter];
    } else {
        NSLog(@"VBWarning: dataWithKey方法依赖于presneter");
    }
}

- (AnyPromise *)dataWithKey:(NSString *)key
{
    if (self.presenter) {
        return [self.presenter dataWithKey:key];
    } else {
        NSLog(@"VBWarning: dataWithKey方法依赖于presneter");
    }
    return nil;
}

- (void)callback:(id)data
{
    if (self.presenter) {
        [self.presenter callback:data];
    } else {
        NSLog(@"VBWarning: callback方法依赖于presneter");
    }
}

- (void)action:(id<RACSubscriber>)subscriber
{
    NSLog(@"%s 仅仅是一个例子",__func__);
}

@end