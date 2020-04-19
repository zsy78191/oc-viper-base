//
//  VB_TableviewComponent+SD.m
//  demo
//
//  Created by 张超 on 2020/4/19.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_TableviewComponent+SD.h"

@implementation VB_TableviewComponent (SD)

+ (instancetype)getStandardTableComponent
{
    VB_TableviewComponent* component = [[VB_TableviewComponent alloc] init];
    component.useDelete = NO;
    component.useInsert = NO;
    component.fullSize = YES;
    return component;
}
@end
