//
//  VB_SVProgressHUDComponent.m
//  viper-base
//
//  Created by 张超 on 2019/8/30.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_SVProgressHUDComponent.h"
@import SVProgressHUD;
@import PromiseKit;
@implementation VB_SVProgressHUDComponent

- (VB_ComponentType)type
{
    return VB_ComponentTypeHUD;
}

- (void)show:(NSString *)msg
{
    [SVProgressHUD showInfoWithStatus:msg];
}

- (void)wait:(NSString *)msg
{
    [SVProgressHUD showWithStatus:msg];
}

- (void)dismiss
{
    [SVProgressHUD dismiss];
}

- (void)success:(NSString *)msg
{
    [SVProgressHUD showSuccessWithStatus:msg];
}


@synthesize showTimeinterval = _showTimeinterval, style = _style;

- (void)setShowTimeinterval:(NSTimeInterval)showTimeinterval
{
    _showTimeinterval = showTimeinterval;
    [SVProgressHUD setMaximumDismissTimeInterval:showTimeinterval];
}

- (void)setStyle:(VB_ComponentTypeHUD_ProtocolStyle)style
{
    _style = style;
    switch (style) {
        case VB_ComponentTypeHUD_ProtocolStyleDark:
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
            break;
        case VB_ComponentTypeHUD_ProtocolStyleLight:
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
            break;
        default:
            [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
            break;
    }
}

@end
