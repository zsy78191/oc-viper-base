//
//  VBCollectionChange.m
//  viper-base
//
//  Created by 张超 on 2019/9/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_CollectionChange.h"
@import UIKit;
@interface VB_CollectionChange()
{
    
}
@property (nonatomic, strong) NSMutableArray* adds;
@property (nonatomic, strong) NSMutableArray* deletes;
@end

@implementation VB_CollectionChange

- (instancetype)initWithArray:(NSArray *)array after:(NSArray *)after
{
    self = [super init];
    if (self) {
        NSMutableArray* a = [array mutableCopy];
        NSMutableArray* b = [after mutableCopy];
        [a removeObjectsInArray:after];
        [b removeObjectsInArray:array];
        NSMutableArray* t = [[NSMutableArray alloc] initWithCapacity:a.count];
        [a enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger index = [array indexOfObject:obj];
            [t addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        }];
        self.deletes = t;
        NSMutableArray* p = [[NSMutableArray alloc] initWithCapacity:b.count];
        [b enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSInteger index = [after indexOfObject:obj];
            [p addObject:[NSIndexPath indexPathForRow:index inSection:0]];
        }];
        self.adds = p;
    }
    return self;
}

- (NSArray<NSIndexPath *> *)deletionsInSection:(NSUInteger)section;
{
    return [self.deletes copy];
}
- (NSArray<NSIndexPath *> *)insertionsInSection:(NSUInteger)section;
{
    return [self.adds copy];
}
- (NSArray<NSIndexPath *> *)modificationsInSection:(NSUInteger)section;
{
    return @[];
}


@end
