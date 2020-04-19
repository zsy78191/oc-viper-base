//
//  VB_ArrayProvider.h
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_DataProvider.h"
@class VB_CollectionChange;

NS_ASSUME_NONNULL_BEGIN

@interface VB_ArrayProvider : VB_DataProvider {
    
}

@property (nonatomic, strong) NSMutableArray* datas;
@property (nonatomic, strong) NSMutableArray* originDatas;

@property (nonatomic, strong) VB_CollectionChange* (^fetch)(void (^)(VB_ArrayProvider* provider));

- (BOOL)has:(NSString*)key value:(id)value;
- (void)setPredicate:(NSPredicate* _Nullable)predicate;

@end

NS_ASSUME_NONNULL_END
