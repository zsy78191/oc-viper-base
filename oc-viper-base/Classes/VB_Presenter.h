//
//  VB_Presenter.h
//  viper-base
//
//  Created by 张超 on 2019/8/23.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Header.h"

@class VB_Interactor;
@class VB_Component;
@protocol VB_ComponentTypePopup_Protocol;

typedef enum : NSUInteger {
    VBStyleInherit,
    VBStyleNone,
    VBStyleUse,
} VBStyle;

NS_ASSUME_NONNULL_BEGIN

@protocol VB_HAS_InteractorProtocol <NSObject>

- (Class)interactorClass;
@property (nonatomic, strong, readonly) __kindof VB_Interactor* interactor;

@end

@protocol VB_Prensenter_Action_Protocol <NSObject>

- (void)push:(__kindof UIViewController*)vc;
- (void)present:(__kindof UIViewController*)vc;
- (void)pop;
- (void)dismissPresenter;

- (AnyPromise*)presentPromise:(__kindof UIViewController*)vc;
- (AnyPromise*)dismissPromise;

@end


/**
 Alert协议
 */
@protocol VB_Prensenter_Alert_Protocol <NSObject>

- (AnyPromise*)alert:(NSString*)msg;
- (AnyPromise*)alert:(UIAlertControllerStyle)style
          selections:(NSArray<NSString*>*)selections
              config:(void (^)(UIAlertController*))config;

- (AnyPromise*)alert:(NSString*)msg sender:(id _Nullable)sender;
- (AnyPromise*)alert:(UIAlertControllerStyle)style
          selections:(NSArray<NSString*>*)selections
              config:(void (^)(UIAlertController*))config
              sender:(id _Nullable)sender;
@end


/**
 HUD协议
 */
@protocol VB_Prensenter_HUD_Protocol <NSObject>

- (void)show:(NSString*)msg;
- (void)success:(NSString*)msg;
- (void)wait:(NSString*)msg;
- (void)dismiss;

@end


/**
 Popup协议
 */
@protocol VB_Prensenter_Popup_Protocol <NSObject>

- (void)popup:(__kindof UIViewController*)vc;
- (void)popup:(__kindof UIViewController*)vc config:(nullable void (^)(id<VB_ComponentTypePopup_Protocol> component))config;
- (void)popdown;

- (AnyPromise*)popupPromise:(__kindof UIViewController*)vc;
- (AnyPromise*)popupPromise:(__kindof UIViewController*)vc config:(nullable void (^)(id<VB_ComponentTypePopup_Protocol> component))config;
- (AnyPromise*)popdownPromise;

@end



@protocol VB_USE_Component <NSObject>

- (void)setupComponent:(__kindof VB_Component*)component;

@end

@interface VB_Presenter : UIViewController <VB_HAS_InteractorProtocol, VB_Prensenter_Action_Protocol, VB_USE_Component, VB_Prensenter_Alert_Protocol,VB_Prensenter_HUD_Protocol,VB_Prensenter_Popup_Protocol>

//- (void)binding:(id)obj keypath:(NSString*)path toObj:(__kindof UIControl*)obj2 keypath:(NSString*)path2;
- (void)binding:(id)obj keypath:(NSString*)path toChannel:(RACChannelTerminal*)channel;

/**
 是否使用工具栏，默认VBStyleInherit
 */
@property (nonatomic, assign) VBStyle toolbarStyle;


/**
 是否使用导航栏，默认VBStyleInherit
 */
@property (nonatomic, assign) VBStyle navibarStyle;

- (void)loadComponents NS_REQUIRES_SUPER;
- (void)createDatasSender:(void (^)(NSString* key, id<RACSubscriber>subcriber))channel;
- (void)dataWithKey:(NSString*)key getter:(void (^)(id data))getter;
- (AnyPromise*)dataWithKey:(NSString*)key;
- (AnyPromise*)callbackData;
- (void)callback:(id)data;

@end

NS_ASSUME_NONNULL_END
