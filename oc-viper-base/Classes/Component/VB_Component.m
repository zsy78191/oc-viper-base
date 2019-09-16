//
//  VB_Component.m
//  viper-base
//
//  Created by 张超 on 2019/8/28.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Component.h"
#import "VB_Interactor.h"
#import "VB_Presenter.h"

@interface VB_Component() {
    
}

@end

@implementation VB_Component

- (VB_Interactor *)interactor
{
    return self.presenter ? self.presenter.interactor : nil;
}

- (VB_ComponentType)type
{
    return VB_ComponentTypeView;
}

- (UIView *)mainView
{
    return nil;
}

@end
