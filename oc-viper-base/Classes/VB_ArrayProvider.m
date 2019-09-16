//
//  VB_ArrayProvider.m
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_ArrayProvider.h"
#import "VB_IndexPathEntity.h"
#import "VB_Component.h"
#import "VBCollectionChange.h"
@import ReactiveObjC;

@implementation VB_ArrayProvider

- (BOOL)has:(NSString *)key value:(id)value
{
    __block BOOL has = NO;
    [self.datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([value isKindOfClass:[NSValue class]]) {
            if ([[obj valueForKey:key] isEqualToValue:value]) {
                has = YES;
                *stop = YES;
            }
        } else if([value isKindOfClass:[NSString class]]) {
            if ([[obj valueForKey:key] isEqualToString:value]) {
                has = YES;
                *stop = YES;
            }
        }
       
    }];
    return has;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        __weak typeof (self) weakself = self;
        self.fetch = ^VBCollectionChange * _Nonnull(void (^ _Nonnull fetcher)(VB_ArrayProvider * _Nonnull provider)) {
            
            NSArray* origin = [weakself.datas copy];
            if (fetcher) {
                fetcher(weakself);
            }
            NSArray* after = [weakself.datas copy];
            return [[VBCollectionChange alloc] initWithArray:origin after:after];
        };
    }
    return self;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _datas;
}

- (void)fetchFunc:(void (^)(VB_ArrayProvider * _Nonnull provider))func {
    if (self.view) {
        VBCollectionChange* change = self.fetch(^(VB_ArrayProvider * _Nonnull provider) {
            if (func) {
                func(provider);
            }
        });
        [self.view applyChanges:change];
    } else {
        if (func) {
            func(self);
        }
    }
}

- (void)addObject:(id)obj
{
    [self fetchFunc:^(VB_ArrayProvider * _Nonnull provider) {
       [provider.datas addObject:obj];
    }];
}

- (void)insertObject:(id)obj at:(NSUInteger)idx
{
    [self fetchFunc:^(VB_ArrayProvider * _Nonnull provider) {
        [provider.datas insertObject:obj atIndex:idx];
    }];
}

- (void)removeObject:(id)obj
{
    [self fetchFunc:^(VB_ArrayProvider * _Nonnull provider) {
        [provider.datas removeObject:obj];
    }];
}

- (void)removeAllObjects
{
    [self fetchFunc:^(VB_ArrayProvider * _Nonnull provider) {
        [provider.datas removeAllObjects];
    }];
}

- (NSUInteger)count
{
    return self.datas.count;
}

- (id)objectAtIndex:(NSUInteger)idx
{
    if (idx >= self.datas.count) {
        return nil;
    }
    return [self.datas objectAtIndex:idx];
}

- (__kindof VB_IndexPathEntity *)objectAtIndexPath:(NSIndexPath *)path
{
    if (!self.useHeader) {
        return [self objectAtIndex:path.row];
    }
    
    VB_IndexPathEntity* entity = [self objectAtIndex:path.section];
    if (path.row >= entity.childrens.count) {
        return nil;
    }
    return [entity.childrens objectAtIndex:path.row];
}

- (id)pop
{
    id obj = [self.datas lastObject];
    if (obj) {
        [self fetchFunc:^(VB_ArrayProvider * _Nonnull provider) {
            [provider.datas removeObject:obj];
        }];
    }
    return obj;
}

- (void)push:(id)obj
{
    [self fetchFunc:^(VB_ArrayProvider * _Nonnull provider) {
        [provider.datas addObject:obj];
    }];
}

@synthesize useHeader, view;

@end
