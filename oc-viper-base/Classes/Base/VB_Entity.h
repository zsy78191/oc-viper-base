//
//  VB_Entity.h
//  viper-base
//
//  Created by 张超 on 2019/8/23.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Mantle;

NS_ASSUME_NONNULL_BEGIN

@interface VB_Entity : MTLModel <MTLJSONSerializing>

- (NSDictionary*)dict;

@end

NS_ASSUME_NONNULL_END
