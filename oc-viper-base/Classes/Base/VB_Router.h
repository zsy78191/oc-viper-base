//
//  VB_Router.h
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <MGJRouter/MGJRouter.h>
@class AnyPromise;

NS_ASSUME_NONNULL_BEGIN

@interface VB_Router : NSObject

@property (class, nonatomic) void (^registTransaction)(VB_Router* router);

+ (AnyPromise*)registTransactionPromise;
+ (AnyPromise*)bind:(NSString*)key entity:(id)entity;
- (void)bind:(NSString*)key entity:(id)entity;
+ (id)entityForKey:(NSString*)key;

+ (AnyPromise*)globalEntityForKey:(NSString*)key;

@end

NS_ASSUME_NONNULL_END
