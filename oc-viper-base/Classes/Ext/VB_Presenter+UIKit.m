//
//  VB_Presenter+UIKit.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/24.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Presenter+UIKit.h"

@implementation VB_Presenter (UIKit)

- (BOOL)isSearchViewControllerResult
{
    if (self.presentingViewController) {
        UIViewController* v = self.presentingViewController;
        if (v.navigationItem) {
            if (v.navigationItem.searchController) {
                return v.navigationItem.searchController.searchResultsController == self;
            }
        }
    }
    return NO;
}

- (VB_Presenter *)parentPresenter
{
    if ([self.parentViewController isKindOfClass:[VB_Presenter class]]) {
        return (VB_Presenter*)[self parentViewController];
    } else if([self.presentingViewController isKindOfClass:[VB_Presenter class]]){
        return (VB_Presenter*)[self presentingViewController];
    }
    return nil;
}

@end
