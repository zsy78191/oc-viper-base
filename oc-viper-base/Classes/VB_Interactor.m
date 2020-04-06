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

- (void)setupComponent:(__kindof VB_Component *)component
{
    
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
