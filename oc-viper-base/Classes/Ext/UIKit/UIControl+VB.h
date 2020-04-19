//
//  UIControl+VB.h
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ReactiveObjC;

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (VB)

- (RACChannelTerminal *)VB_ChannelForControlEvents:(UIControlEvents)controlEvents key:(NSString *)key nilValue:(id)nilValue;

@end

NS_ASSUME_NONNULL_END
