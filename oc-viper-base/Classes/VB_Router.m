//
//  VB_Router.m
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Router.h"
#import "VB_Router+Hide.h"

@import PromiseKit;

@implementation VB_Router

@dynamic registTransaction;



- (instancetype)init
{
    self = [super init];
    if (self) {
//        if()
    }
    return self;
}

+ (void)setRegistTransaction:(void (^)(VB_Router * _Nonnull))registTransaction {
    registTransaction([[self class] sharedInstance]);
}

+ (void (^)(VB_Router * _Nonnull))registTransaction {
    return nil;
}

- (void)bind:(NSString *)key entity:(id)entity
{
    [MGJRouter registerURLPattern:key toObjectHandler:^id(NSDictionary *routerParameters) {
        return entity;
    }];
}

+ (id)entityForKey:(NSString *)key
{
    return [MGJRouter objectForURL:key];
}

+ (AnyPromise *)globalEntityForKey:(NSString *)key
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        id d = [[self class] entityForKey:key];
        if (d) {
            r(d);
        } else {
            r([NSError errorWithDomain:@"VBErrorDomain" code:202 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"全局参数%@没有注册",key]}]);
        }
        
    }];
}

@end
