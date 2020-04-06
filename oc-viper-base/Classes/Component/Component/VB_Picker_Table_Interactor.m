//
//  VB_Picker_Table_Interactor.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/4/3.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Picker_Table_Interactor.h"
#import "VB_Presenter.h"
#import "VB_ArrayProvider.h"
#import "VB_TableviewComponent.h"
#import "VB_IndexPathEntity.h"
#import "VB_Out_Header.h"
@interface VB_Picker_Table_Interactor ()
@property (nonatomic, strong) VB_ArrayProvider* dataSource;
@end

@implementation VB_Picker_Table_Interactor

- (id)preloadData
{
    NSArray* selections = self.presenter.needData(@"selections");
    NSNumber* selected = self.presenter.needData(@"selected");
//    NSLog(@"%@",selections);
    [selections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        VB_IndexPathEntity* entity = [[VB_IndexPathEntity alloc] init];
        entity.identifier = @"MainCell";
        entity.title = obj;
        if (idx == [selected integerValue]) {
            entity.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        [self.dataSource addObject:entity];
    }];
    return @YES;
}


- (VB_ArrayProvider *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[VB_ArrayProvider alloc] init];
    }
    return _dataSource;
}

- (void)setupComponent:(__kindof VB_Component *)component
{
    if ([component isKindOfClass:[VB_TableviewComponent class]]) {
        [(VB_TableviewComponent*)component setDataSource:self.dataSource];
    }
}

- (void)tableViewDidSelect:(PMKResolver)resolver param:(id)param
{
    NSIndexPath* p = param;
//    VB_IndexPathEntity* e = [self.dataSource objectAtIndexPath:param];
    [self.presenter promiseWithName:@"ensere" param:@(p.row)];
    resolver(@1);
}

@end
