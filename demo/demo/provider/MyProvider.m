//
//  MyProvider.m
//  demo
//
//  Created by 张超 on 2020/4/19.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "MyProvider.h"
#import "EntityItem+CoreDataClass.h"
#import "VB_Out_Header.h"
@import MagicalRecord;
@implementation MyProvider

- (VB_IndexPathEntity *)entityWithOrigin:(id)entity
{
    VB_IndexPathEntity* e = [super entityWithOrigin:entity];
    EntityItem* item = entity;
    e.title = item.title;
    e.detial = [@(item.sort) description];
    return e;
}

- (void)configBeforeInsertToDatabase:(EntityItem*)item
{
    item.title = [@"Titie - " stringByAppendingString:[[NSDate date]description]];
     EntityItem*  i = [EntityItem MR_findFirstOrderedByAttribute:@"sort" ascending:NO];
    if(!i) {
        item.sort = 1;
    } else {
        item.sort = i.sort + 1;
    }
    item.category = arc4random() % 3;
}

- (NSString *)groupBy
{
    return @"Category";
}

@end
