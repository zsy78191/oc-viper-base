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


- (AnyPromise *)show:(__kindof UIViewController *)viewController {
    return [self show:viewController usePush:YES];
}

- (AnyPromise *)show:(__kindof UIViewController *)viewController usePush:(BOOL)usePush;
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        self.resolver = r;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if (viewController.splitViewController) {
                UINavigationController* n = [[UINavigationController alloc] initWithRootViewController:self];
                n.modalPresentationStyle = UIModalPresentationFormSheet;
                [viewController.splitViewController presentViewController:n animated:YES completion:nil];
            } else {
                UINavigationController* n = [[UINavigationController alloc] initWithRootViewController:self];
                n.modalPresentationStyle = UIModalPresentationFormSheet;
                [viewController presentViewController:n animated:YES completion:nil];
            }
        } else {
            UINavigationController* navi = nil;
            if ([viewController isKindOfClass:[UINavigationController class]]) {
                navi = viewController;
            } else if(viewController.navigationController) {
                navi = viewController.navigationController;
            }
            if (navi && usePush) {
                [navi pushViewController:self animated:YES];
            } else {
                UINavigationController* n = [[UINavigationController alloc] initWithRootViewController:self];
                n.modalPresentationStyle = UIModalPresentationFormSheet;
                [viewController presentViewController:n animated:YES completion:nil];
            }
        }
    }];
}


@end
