//
//  VB_DataProvider.m
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_DataProvider.h"

@implementation VB_DataProvider


- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (VB_IndexPathEntity *)entityWithOrigin:(id)entity
{
    return entity;
}

- (NSUInteger)sectionsCount
{
    return 1;
}

- (NSUInteger)count
{
    return [self countForSection:0];
}

- (NSString *)titleForSection:(NSUInteger)section
{
    return nil;
}

- (NSString *)titleForSectionFooter:(NSUInteger)section
{
    return nil;
}


@end
