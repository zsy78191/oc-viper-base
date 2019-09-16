//
//  VB_TableviewComponent.h
//  viper-base
//
//  Created by 张超 on 2019/8/28.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Component.h"

@class VBCollectionChange;
NS_ASSUME_NONNULL_BEGIN

@interface VB_TableviewComponent : VB_Component <VB_ComponentTypeView_Protocol>

- (void)registCell:(Class)className forIdentifier:(NSString*)identifer;

@property (nonatomic, assign) BOOL useDelete;
@property (nonatomic, assign) BOOL useInsert;

- (void)setEditing:(BOOL)e animated:(BOOL)a;
@property (nonatomic, assign) BOOL editing;

@end

NS_ASSUME_NONNULL_END