//
//  UIControl+VB.m
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "UIControl+VB.h"

@implementation UIControl (VB)

- (RACChannelTerminal *)VB_ChannelForControlEvents:(UIControlEvents)controlEvents key:(NSString *)key nilValue:(id)nilValue {
    NSCParameterAssert(key.length > 0);
    key = [key copy];
    RACChannel *channel = [[RACChannel alloc] init];
    
    [self.rac_deallocDisposable addDisposable:[RACDisposable disposableWithBlock:^{
        [channel.followingTerminal sendCompleted];
    }]];
    
    RACSignal *eventSignal = [[[self
                                rac_signalForControlEvents:controlEvents]
                               mapReplace:key]
                              takeUntil:[[channel.followingTerminal
                                          ignoreValues]
                                         catchTo:RACSignal.empty]];
    [[self
      rac_liftSelector:@selector(valueForKey:) withSignals:eventSignal, nil]
     subscribe:channel.followingTerminal];
    
    RACSignal *valuesSignal = [channel.followingTerminal
                               map:^(id value) {
                                   return value ?: nilValue;
                               }];
    [self rac_liftSelector:@selector(setValue:forKey:) withSignals:valuesSignal, [RACSignal return:key], nil];
    
    return channel.leadingTerminal;
}

@end
