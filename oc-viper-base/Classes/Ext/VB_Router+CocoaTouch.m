//
//  VB_Router+CocoaTouch.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/26.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Router+CocoaTouch.h"
@import UIKit;
@import PromiseKit;
#import "VB_Router+Hide.h"

@implementation VB_Router (CocoaTouch)

- (NSArray*)systemScheme {
    return @[
        @"App-Prefs:root=Privacy", // 隐私
        @"App-Prefs:root=WIFI", // wifi
        @"App-Prefs:root=Bluetooth", // 蓝牙
        @"App-Prefs:root=MOBILE_DATA_SETTINGS_ID", // 移动蜂窝网
        @"App-Prefs:root=INTERNET_TETHERING", // 个人热点
        @"App-Prefs:root=Carrier", // 蜂窝网络
        @"App-Prefs:root=NOTIFICATIONS_ID", //通知
        @"App-Prefs:root=General" ,// 通用
        @"App-Prefs:root=General&path=About", //关于本机
        @"App-Prefs:root=General&path=Keyboard", // 键盘
        @"App-Prefs:root=General&path=ACCESSIBILITY", //辅助功能
        @"App-Prefs:root=General&path=INTERNATIONAL", //语言地区
        @"App-Prefs:root=Reset", //还原
        @"App-Prefs:root=Wallpaper", //墙纸
        @"App-Prefs:root=SIRI", // siri
        @"App-Prefs:root=SAFARI", // safari
        @"App-Prefs:root=MUSIC",
        @"App-Prefs:root=MUSIC&path=com.apple.Music:EQ",
        @"App-Prefs:root=Photos",
        @"App-Prefs:root=FACETIME",
    ];
}

- (BOOL)canOpenURL:(NSURL*)url;
{
    return [[UIApplication sharedApplication] canOpenURL:url];
}

- (AnyPromise*)openURL:(NSURL*)url {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            r(@(success));
        }];
    }];
}

- (NSURL*)urlForWay:(SystemSchemeType)type
{
    return [NSURL URLWithString:[[self systemScheme] objectAtIndex:type]];
}

+ (AnyPromise*)systemSchemeJump:(SystemSchemeType)type {
    VB_Router* r = [[self class] sharedInstance];
    return [r openURL:[r urlForWay:type]];
}

+ (AnyPromise *)systemSchemeJumpSelf
{
    VB_Router* r = [[self class] sharedInstance];
    return [r openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

@end
