//
//  VBCollectionChange.h
//  viper-base
//
//  Created by 张超 on 2019/9/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VBCollectionChange : NSObject

- (instancetype)initWithArray:(NSArray*)array after:(NSArray*)after;

- (NSArray<NSIndexPath *> *)deletionsInSection:(NSUInteger)section;
- (NSArray<NSIndexPath *> *)insertionsInSection:(NSUInteger)section;
- (NSArray<NSIndexPath *> *)modificationsInSection:(NSUInteger)section;
@end

NS_ASSUME_NONNULL_END
