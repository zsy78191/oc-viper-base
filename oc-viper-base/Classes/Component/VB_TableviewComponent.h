//
//  VB_TableviewComponent.h
//  viper-base
//
//  Created by 张超 on 2019/8/28.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Component.h"

@class VB_CollectionChange;
NS_ASSUME_NONNULL_BEGIN

@interface VB_TableviewComponent : VB_Component <VB_ComponentTypeView_Protocol>
{
    
}

@property (nonatomic, assign) UITableViewStyle tableStyle;

- (void)registCell:(Class)className forIdentifier:(NSString*)identifer;
- (void)registHeader:(Class)className forIdentifier:(NSString*)identifer;

@property (nonatomic, assign) BOOL useDelete;
@property (nonatomic, assign) BOOL useInsert;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;
@property (nonatomic, assign) BOOL editing;

@end

NS_ASSUME_NONNULL_END
