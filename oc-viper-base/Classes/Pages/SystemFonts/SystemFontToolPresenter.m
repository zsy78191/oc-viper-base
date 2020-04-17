//
//  SystemFontToolPresenter.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/22.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SystemFontToolPresenter.h"
#import "VB_Out_Header.h"

@interface SystemFontToolPresenter () <UISearchResultsUpdating>
@property (nonatomic, strong) VB_TableviewComponent* tableComponent;

@end

@implementation SystemFontToolPresenter

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
      if (@available(iOS 13.0, *)) {
          self.view.backgroundColor  = [UIColor systemBackgroundColor];
      }
 
}

- (void)loadComponents
{
    [super loadComponents];
    
    id needSearchBar = self.needData(@"needSearchBar");
    self.needSearchBar = needSearchBar?[needSearchBar boolValue]:YES;
    
    self.tableComponent = [[VB_TableviewComponent alloc] init];
    self.tableComponent.fullSize = YES;
    [self setupComponent:self.tableComponent];
    [self.tableComponent registCell:NSClassFromString(@"DemoMainListCell") forIdentifier:@"FontCell"];
    [self.tableComponent registCell:NSClassFromString(@"DemoMainListCell") forIdentifier:@"FontChildCell"];
    
    if (self.needSearchBar) {
        SystemFontToolPresenter* searchResult = [[SystemFontToolPresenter alloc] init];
        searchResult.needData = ^id _Nonnull(NSString * _Nonnull key) {
            if ([key isEqualToString:@"needSearchBar"]) {
                return @(NO);
            }
            return nil;
        };
        self.navigationItem.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResult];
          if (@available(iOS 13.0, *)) {
              self.navigationItem.searchController.automaticallyShowsCancelButton = YES;
          }
        self.navigationItem.searchController.searchResultsUpdater = self;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"导入" style:UIBarButtonItemStylePlain target:nil action:nil];
        [self.navigationItem.rightBarButtonItem setRac_command:[self.interactor commandWithName:@"importFonts:sender:"]];
    }
    
    VB_SVProgressHUDComponent* c = [[VB_SVProgressHUDComponent alloc] init];
    c.showTimeinterval = 1;
    [self setupComponent:c];
    
    VB_AlertComponent* alert = [[VB_AlertComponent alloc] init];
    [self setupComponent:alert];
    
    if (self.needData) {
        NSString* family = self.needData(@"family");
        if ([family isEqualToString:@"用户导入字体"]) {
            self.tableComponent.useDelete = YES;
        }
        NSString* title = self.needData(@"title");
        if (title) {
            self.title = title;
        }
    }

    [self.interactor promiseWithName:@"preLoad"];
}

- (id)ensure:(PMKResolver)resolver param:(id)param {
    if (self.resolver) {
        self.resolver(param);
    }
    resolver(@1);
    return @YES;
}

- (void)push:(__kindof UIViewController *)vc
{
    if ([vc isKindOfClass:[SystemFontToolPresenter class]]) {
        [(SystemFontToolPresenter*)vc setResolver:self.resolver];
    }
    [super push:vc];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString* str = searchController.searchBar.text;
    SystemFontToolPresenter* searchResult = (SystemFontToolPresenter*)self.navigationItem.searchController.searchResultsController;
    searchResult.resolver = self.resolver;
    [searchResult.interactor promiseWithName:@"setFilterString" param:str];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationItem.searchController setActive:NO];
}

- (Class)interactorClass
{
    return NSClassFromString(@"SystemFontToolInteractor");
}

- (void)reloadData {
    [self.tableComponent reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
