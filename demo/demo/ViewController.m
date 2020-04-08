//
//  ViewController.m
//  demo
//
//  Created by 张超 on 2020/4/6.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "ViewController.h"
#import "VB_Out_Header.h"
#import "SystemFontToolPresenter.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)openFont:(id)sender {
    SystemFontToolPresenter* p = [[SystemFontToolPresenter alloc] init];
    p.needData = ^id _Nonnull(NSString * _Nonnull key) {
        if ([key isEqualToString:@"title"]) {
            return @"选择字体";
        }
        return nil;
    };
    [p show:self].then(^(id d) {
        NSLog(@"%@",d);
        [self closePresenter];
    });
}


@end
