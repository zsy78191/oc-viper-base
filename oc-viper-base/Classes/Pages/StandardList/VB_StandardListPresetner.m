//
//  VB_StandardListPresetner.m
//  demo
//
//  Created by 张超 on 2020/4/19.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_StandardListPresetner.h"
#import "VB_Out_Header.h"

@interface VB_StandardListPresetner ()
{
    
}
@property (nonatomic, strong) VB_TableviewComponent* tableComponent;

@end

@implementation VB_StandardListPresetner

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (Class)interactorClass
{
    return NSClassFromString(@"VB_StandardListInteractor");
}

- (void)loadComponents
{
    [super loadComponents];
    self.tableComponent = [VB_TableviewComponent getStandardTableComponent];
    self.tableComponent.tableStyle = [self.needData(@"tableStyle") integerValue];
    [self setupComponent:self.tableComponent];
    
    UIBarButtonItem * add = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:nil action:nil];
    [add setRac_command:[self.interactor commandWithName:@"addNewItem"]];
    
    self.navigationItem.rightBarButtonItems = @[add,self.editButtonItem];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableComponent setEditing:editing animated:animated];
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
