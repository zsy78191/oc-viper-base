//
//  VB_Presenter.h
//  viper-base
//
//  Created by 张超 on 2019/8/23.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Header.h"
#import "VB_Component.h"

@class VB_Interactor;
@class VB_Component;
@protocol VB_ComponentTypePopup_Protocol;
@protocol VB_ComponentTypeAlert_Protocol;
@protocol VB_ComponentTypePicker_Protocol;

typedef enum : NSUInteger {
    VBStyleInherit,  /// 继承前者
    VBStyleNone,     /// 不使用
    VBStyleUse,      /// 使用
} VBStyle;

NS_ASSUME_NONNULL_BEGIN

@protocol VB_HAS_InteractorProtocol <NSObject>

/// 继承修改Interacter的类型
- (Class)interactorClass;

/// interactor对象，一个Presenter只有一个Interactor，额外的Interactor需要额外挂载
@property (nonatomic, strong, readonly) __kindof VB_Interactor* interactor;

@end

/// 视图导航方法
@protocol VB_Prensenter_Action_Protocol <NSObject>

- (void)push:(__kindof UIViewController*)vc;
- (void)present:(__kindof UIViewController*)vc;
- (void)present:(__kindof UIViewController*)vc completion:(void (^ __nullable)(void))completion;
- (void)pop;
- (void)popToRoot;
- (void)dismissPresenter;

- (AnyPromise*)presentPromise:(__kindof UIViewController*)vc;
- (AnyPromise*)dismissPromise;

@end

/// Alert
@protocol VB_Prensenter_Alert_Protocol <VB_ComponentTypeAlert_Protocol>

- (AnyPromise*)alert:(NSString *)msg;

@end

/// HUD
@protocol VB_Prensenter_HUD_Protocol <NSObject>

- (void)hudShow:(NSString*)msg;
- (void)hudSuccess:(NSString*)msg;
- (void)hudWait:(NSString*)msg;
- (void)hudDismiss;

@end


/// Picker
@protocol VB_Prensenter_Picker_Protocol <VB_ComponentTypePicker_Protocol>

@end

///  Popup
@protocol VB_Prensenter_Popup_Protocol <NSObject>

- (void)popup:(__kindof UIViewController*)vc;
- (void)popup:(__kindof UIViewController*)vc config:(nullable void (^)(id<VB_ComponentTypePopup_Protocol> component))config;
- (void)popdown;

- (AnyPromise*)popupPromise:(__kindof UIViewController*)vc;
- (AnyPromise*)popupPromise:(__kindof UIViewController*)vc config:(nullable void (^)(id<VB_ComponentTypePopup_Protocol> component))config;
- (AnyPromise*)popdownPromise;

@end

/// 组件
@protocol VB_USE_Component <NSObject>

/// 加载组件
/// @param component 组件对象
- (void)setupComponent:(__kindof VB_Component*)component;

@end

@interface VB_Presenter : UIViewController <VB_HAS_InteractorProtocol,VB_Prensenter_Action_Protocol, VB_USE_Component, VB_Prensenter_Alert_Protocol,VB_Prensenter_HUD_Protocol,VB_Prensenter_Popup_Protocol,VB_Prensenter_Picker_Protocol>

/// 双向绑定
/// @param obj 对象
/// @param path 属性
/// @param channel 控件的RACChannel
- (void)binding:(id)obj keypath:(NSString*)path toChannel:(RACChannelTerminal*)channel;

/// 是否使用工具条，默认VBStyleInherit
@property (nonatomic, assign) VBStyle toolbarStyle;

/// 是否使用导航栏，默认VBStyleInherit
@property (nonatomic, assign) VBStyle navibarStyle;

/// 请继承这个方法加载组件
- (void)loadComponents NS_REQUIRES_SUPER;

/// 注册外部数据，一般外部调用
@property (nonatomic, strong, nullable) void (^needLoadData)(NSString* key, id<RACSubscriber>subcriber);

/// 注册外部数据，一般外部调用
@property (nonatomic, strong, nullable) id (^needData)(NSString* key);
@property (nonatomic, strong, nullable) id (^needDataDef)(NSString* key, id defaultValue);

#pragma mark - Life Time Hook
- (AnyPromise*)didDismissHook;
- (id)objectForReturn;

@end

NS_ASSUME_NONNULL_END
