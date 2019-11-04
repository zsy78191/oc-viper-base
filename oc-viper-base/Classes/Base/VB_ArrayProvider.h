//
//  VB_ArrayProvider.h
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_DataProvider.h"
@class VBCollectionChange;

NS_ASSUME_NONNULL_BEGIN

@interface VB_ArrayProvider : VB_DataProvider {
    
}

@property (nonatomic, strong) NSMutableArray* datas;

@property (nonatomic, strong) VBCollectionChange* (^fetch)(void (^)(VB_ArrayProvider* provider));

- (BOOL)has:(NSString*)key value:(id)value;

@end

NS_ASSUME_NONNULL_END
