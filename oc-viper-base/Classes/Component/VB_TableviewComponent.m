//
//  VB_TableviewComponent.m
//  viper-base
//
//  Created by 张超 on 2019/8/28.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_TableviewComponent.h"
#import "VB_DataProvider.h"
#import "VB_IndexPathEntity.h"
#import "VB_Interactor.h"
#import "VBCollectionChange.h"
#import "UITableViewCell+VB.h"
@import Masonry;
@import Classy;

@interface VB_TableviewComponent () <UITableViewDataSource, UITableViewDelegate>
{
    
}
@property (nonatomic, assign) UITableViewCellEditingStyle style;
@property (nonatomic, weak) __kindof UITableView* view;
@property (nonatomic, assign) BOOL empty;

@property (nonatomic, strong) UILabel* tipLabel;

@end

@implementation VB_TableviewComponent

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.useInsert = NO;
        self.useDelete = NO;
    }
    return self;
}

@synthesize fullSize,dataSource = _dataSource;


- (UIView *)managedView
{
    UITableView* tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) style:UITableViewStylePlain];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.view = tableView;
    tableView.backgroundView = [[UIView alloc] initWithFrame:tableView.bounds];
    self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 50)];
    self.tipLabel.text = @"NO Data";
    self.tipLabel.cas_styleClass = @"tiplabel";
    [tableView.backgroundView addSubview:self.tipLabel];
    self.tipLabel.center = tableView.center;
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(tableView.backgroundView);
        make.centerY.equalTo(tableView.backgroundView);
    }];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setTableFooterView:[UIView new]];
    return tableView;
}

#pragma mark - tableviewdatasource

- (void)setDataSource:(__kindof VB_DataProvider *)dataSource
{
    _dataSource = dataSource;
    _dataSource.view = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.empty = YES;
    if (self.dataSource) {
        self.empty = [self.dataSource count] == 0 ? YES : NO;
    }
    return self.dataSource? [self.dataSource count] : 0;
}

- (void)setEmpty:(BOOL)empty
{
    _empty = empty;
    self.tipLabel.hidden = !empty;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VB_IndexPathEntity* entity = [self.dataSource objectAtIndexPath:indexPath];
    __kindof UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:entity.identifier forIndexPath:indexPath];
    [self configCell:cell entity:entity];
    return cell;
}

- (void)configCell:(__kindof UITableViewCell*)cell entity:(VB_IndexPathEntity*)entity
{
    cell.textLabel.text = entity.title;
    cell.detailTextLabel.text = entity.subTitle;
    if ([cell respondsToSelector:@selector(loadData:)]) {
        [cell loadData:entity];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.interactor.paramPromise(@"tableViewDidSelect",indexPath).then(^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }).catch(^ (NSError* e){
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSLog(@"%@",e);
    });
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

- (void)reloadData
{
    [self.view reloadData];
}

- (VB_ComponentType)type
{
    return VB_ComponentTypeView;
}

- (void)registCell:(Class)className forIdentifier:(NSString *)identifer
{
    NSString* nibName = NSStringFromClass(className);
    UINib* nib = [UINib nibWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (nib) {
        [self.view registerNib:nib forCellReuseIdentifier:identifer];
    } else {
        [self.view registerClass:className forCellReuseIdentifier:identifer];
    }
}

- (void)applyChanges:(VBCollectionChange*)changes
{
    UITableView *tableView = self.view;
    // Initial run of the query will pass nil for the change information
    if (!changes) {
        [tableView reloadData];
        return;
    }
    
    // Query results have changed, so apply them to the UITableView
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:[changes deletionsInSection:0]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView insertRowsAtIndexPaths:[changes insertionsInSection:0]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView reloadRowsAtIndexPaths:[changes modificationsInSection:0]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    [tableView endUpdates];
}

- (UIView *)mainView
{
    return self.view;
}

- (void)setUseDelete:(BOOL)useDelete
{
    _useDelete = useDelete;
    [self updateEditStyle];
}

- (void)setUseInsert:(BOOL)useInsert
{
    _useInsert = useInsert;
    [self updateEditStyle];
}

- (void)updateEditStyle
{
    self.style = self.useDelete ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
    self.style = self.useInsert ? self.style | UITableViewCellEditingStyleInsert : self.style;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.style;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        self.interactor.paramPromise(@"tableViewDidDelete",indexPath).then(^{
        }).catch(^ (NSError* e){
            NSLog(@"%@",e);
        });
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        self.interactor.paramPromise(@"tableViewDidInsert",indexPath).then(^{
        }).catch(^ (NSError* e){
            NSLog(@"%@",e);
        });
    }
}

- (void)setEditing:(BOOL)e animated:(BOOL)a {
    [self.view setEditing:e animated:a];
    self.editing = e;
}

@end
