//
//  MySetting.m
//  demo
//
//  Created by 张超 on 2020/4/8.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "MySetting.h"

@implementation MySetting

- (NSDictionary *)dictForTitle
{
    return @{
        @"title" : @"标题",
        @"title1" : @"标题1",
        @"title2" : @"标题2",
    };
}


- (SettingItemType)typeForKey:(NSString *)key
{
    return SettingItemTypeText;
}

- (void)configItem:(SettingItemEntity *)item
{
    
}
 
@end
