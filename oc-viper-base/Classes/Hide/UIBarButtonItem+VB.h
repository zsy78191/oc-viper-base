//
//  UIBarButtonItem+VB.h
//  viper-base
//
//  Created by 张超 on 2019/8/30.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AnyPromise;
NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (VB)

- (void)setPromise:(id)sender selector:(SEL)selector;

@end

@interface UIButton (VB)

- (void)setPromise:(id)sender selector:(SEL)selector;

@end


NS_ASSUME_NONNULL_END
