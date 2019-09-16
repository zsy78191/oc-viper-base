
//
//  AppDelegate+VB.m
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "AppDelegate+VB.h"
#import "VB_Out_Header.h"
#import "VB_SettingModel.h"
#import "DemoAuthorizationEntity.h"
#import "VB_FontLoader.h"

@import Classy;
@import MagicalRecord;

@implementation AppDelegate (VB)


- (void)registDefault;{
    NSDictionary* defalut = @{
                              @"_mainFont" : @"PingFangSC-Thin"
                              };
    [[NSUserDefaults standardUserDefaults] registerDefaults:defalut];
}

- (void)registRouter;{
    [VB_Router setRegistTransaction:^(VB_Router * _Nonnull router) {
        VB_SettingModel* model = [[VB_SettingModel alloc] init];
        [router bind:@"set" entity:model];
    }];
    
    [VB_Router setRegistTransaction:^(VB_Router * _Nonnull router) {
        DemoAuthorizationEntity* model = [[DemoAuthorizationEntity alloc] init];
        [router bind:@"auth" entity:model];
    }];
    
    [VB_Router setRegistTransaction:^(VB_Router * _Nonnull router) {
        VB_ImportFontEntity* model = [[VB_ImportFontEntity alloc] init];
        [router bind:@"font" entity:model];
    }];
}

- (void)useCoreData
{
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Model"];
}


- (void)classy
{
    NSArray* fonts = [VB_FontLoader autoRegistFont];
   
    [VB_Router globalEntityForKey:@"font"].then(^(VB_ImportFontEntity*font) {
        [font.importedFonts addObjectsFromArray:fonts];
    });
    
    [CASStyler bootstrapClassyWithTargetWindows:UIApplication.sharedApplication.windows];
//    [[CASStyler defaultStyler] setTargetWindows:UIApplication.sharedApplication.windows];
    
#if TARGET_IPHONE_SIMULATOR
    NSString *absoluteFilePath = CASAbsoluteFilePath(@"./stylesheet.cas");
    [CASStyler defaultStyler].watchFilePath = absoluteFilePath;
#endif
    
    
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    __weak typeof(self) weakself = self;
    [VB_Router globalEntityForKey:@"set"].then(^(VB_SettingModel* set) {
        [RACObserve(set, mainFont) subscribeNext:^(id  _Nullable x) {
            if (x) {
                NSLog(@"11 %@",x);
                [weakself changeFont:x];
            }
        }];
    });
}

- (void)changeFont:(NSString*)font
{
    [[CASStyler defaultStyler] setVariables:@{
                                              @"$font3":font
                                              }];
    [[CASStyler defaultStyler] setTargetWindows:UIApplication.sharedApplication.windows];
}

@end
