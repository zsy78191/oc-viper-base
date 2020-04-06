//
//  VB_Router+Hide.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/26.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Router+Hide.h"
 
@implementation VB_Router (Hide)
+ (instancetype)sharedInstance {
    static VB_Router * _g_shared_router_vb = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _g_shared_router_vb = [[VB_Router alloc] init];
    });
    return _g_shared_router_vb;
}
@end
