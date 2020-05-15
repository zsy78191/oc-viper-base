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

@interface VB_Interactor ()
{
    
}
@property (nonatomic, strong) NSHashTable* childrens;
@end


@implementation VB_Interactor

- (AnyPromise *)setupInteractor:(VB_Interactor*)interactor
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        if (interactor) {
            [self.childrens addObject:interactor];
            interactor.parentInteractor = self;
            r(interactor);
        } else {
            r(nil);
        }
    }];
}

- (NSHashTable *)childrens
{
    if (!_childrens) {
        _childrens = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsStrongMemory capacity:10];
    }
    return _childrens;
}

- (id)entityForKey:(NSString *)key
{
    return [self valueForKeyPath:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return nil;
}

- (void)setupComponent:(__kindof VB_Component *)component
{
//    NSLog(@"N");
}

- (void)loadComponents {
    
}

- (AnyPromise *)ensure:(id)item isKindOf:(Class)class
{
    return [AnyPromise promiseWithAdapterBlock:^(PMKAdapter  _Nonnull adapter) {
        if ([item isKindOfClass:class]) {
            adapter(item, NULL);
        } else {
            adapter(NULL,[NSError errorWithDomain:@"ViperBase" code:100 userInfo:@{NSLocalizedDescriptionKey:@"类型不符"}]);
        }
    }];
}

- (void)dataUpdate
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
    [self.childrens removeAllObjects];
    NSLog(@"** %@ %s",[self class],__func__);
}

- (void)action:(id<RACSubscriber>)subscriber
{
    NSLog(@"%s 仅仅是一个例子",__func__);
}

- (id)preloadData
{
    return @(YES);
}

@end
