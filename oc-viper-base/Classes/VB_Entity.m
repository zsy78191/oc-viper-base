//
//  VB_Entity.m
//  viper-base
//
//  Created by 张超 on 2019/8/23.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Entity.h"

@interface VB_Entity () {
    
}
@property (nonatomic, strong) NSMutableDictionary* extraData;

@end

@implementation VB_Entity

- (NSMutableDictionary *)extraData {
    if (!_extraData) {
        _extraData = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    return _extraData;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    [self.extraData setValue:value forUndefinedKey:key];
}

- (id)valueForUndefinedKey:(NSString *)key
{
    return [self.extraData valueForKey:key];
}

@end
