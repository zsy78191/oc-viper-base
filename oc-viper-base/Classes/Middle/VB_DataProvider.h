//
//  VB_DataProvider.h
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VB_IndexPathEntity;
@protocol VB_ComponentTypeView_Protocol;

NS_ASSUME_NONNULL_BEGIN

@protocol VB_Data_Provider_protocol <NSObject>
@optional

- (void)addObject:(__kindof VB_IndexPathEntity*)obj;
- (void)addObjects:(NSArray*)objs;
- (void)insertObject:(__kindof VB_IndexPathEntity*)obj at:(NSUInteger)idx;
- (void)removeObject:(__kindof VB_IndexPathEntity*)obj;
- (void)removeAllObjects;
- (__kindof VB_IndexPathEntity*)objectAtIndex:(NSUInteger)idx;
- (__kindof VB_IndexPathEntity*)pop;
- (void)push:(__kindof VB_IndexPathEntity*)obj;
- (NSUInteger)count;
- (NSUInteger)countForSection:(NSUInteger)section;
- (NSUInteger)sectionsCount;
- (NSString*)titleForSection:(NSUInteger)section;
- (NSString*)titleForSectionFooter:(NSUInteger)section;

@property (nonatomic, assign) BOOL useHeader;
@property (nonatomic, weak) id<VB_ComponentTypeView_Protocol> view;

- (__kindof VB_IndexPathEntity*)objectAtIndexPath:(NSIndexPath*)path;

- (void)reuseEntity:(VB_IndexPathEntity*)entity;

@end


@interface VB_DataProvider : NSObject <VB_Data_Provider_protocol>
{
    
}



@end

NS_ASSUME_NONNULL_END
