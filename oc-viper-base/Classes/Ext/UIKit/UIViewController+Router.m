//
//  UIViewController+Router.m
//  demo
//
//  Created by 张超 on 2020/4/7.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "UIViewController+Router.h"
 

@implementation UIViewController (Router)

- (void)closePresenter
{
   if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
       [self dismissViewControllerAnimated:YES completion:^{
           
       }];
   } else {
       if (!self.navigationController || self.navigationController.topViewController == self) {
           [self dismissViewControllerAnimated:YES completion:^{
               
           }];
       } else {
           if ([self.navigationController.viewControllers containsObject:self]) {
               [[self navigationController] popToViewController:self animated:YES];
           } else {
               [[self navigationController] popToRootViewControllerAnimated:YES];
           }
       }
   }
}


@end
