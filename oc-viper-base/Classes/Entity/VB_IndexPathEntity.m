//
//  VB_IndexPathEntity.m
//  viper-base
//
//  Created by 张超 on 2019/8/28.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_IndexPathEntity.h"

@implementation VB_IndexPathEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.identifier = @"cell";
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.accessoryType = UITableViewCellAccessoryNone;
    }
    return self;
}

- (NSMutableArray<__kindof VB_Entity *> *)childrens
{
    if (!_childrens) {
        _childrens = [[NSMutableArray alloc] init];
    }
    return _childrens;
}

- (NSString *)description
{
    return [[super description] stringByAppendingFormat:@"%@",[self.childrens componentsJoinedByString:@"|"]];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end
