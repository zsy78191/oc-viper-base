//
//  VB_FormatterManager.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/27.
//  Copyright © 2020 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VB_FormatterManager : NSObject

+ (instancetype) sharedManager;

@property (nonatomic, strong) NSNumberFormatter* numberFormatter;

@end

NS_ASSUME_NONNULL_END
