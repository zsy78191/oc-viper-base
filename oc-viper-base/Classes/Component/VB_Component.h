//
//  VB_Component.h
//  viper-base
//
//  Created by 张超 on 2019/8/28.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VB_Interactor, VB_Presenter, VB_DataProvider, AnyPromise, VB_CollectionChange;

typedef enum : NSUInteger {
    VB_ComponentTypeView,
    VB_ComponentTypeAlert,
    VB_ComponentTypeHUD,
    VB_ComponentTypePopup,
    VB_ComponentTypePicker,
} VB_ComponentType;

NS_ASSUME_NONNULL_BEGIN

@protocol VB_ComponentTypeView_Protocol <NSObject>

/// 每次返回一个新实例View
- (__kindof UIView* _Nullable)managedView;

/// 当前的管理实例View
- (__kindof UIView*) mainView;

/// 铺满父控件
@property (nonatomic, assign) BOOL fullSize;

- (void)reloadData;
- (void)reloadDataAtIndexPath:(NSIndexPath*)path;

@property (nonatomic, weak) __kindof VB_DataProvider* _Nullable dataSource;
- (void)applyChanges:(VB_CollectionChange* _Nullable)changes;

- (void)view:(UIView*)view didAddToView:(UIView*)superView;

@end

@protocol VB_ComponentTypeAlert_Protocol <NSObject>

/// 普通Alert
/// @param msg 信息
/// @param sender 触发控件，主要用于UIBarButtonItem
- (AnyPromise*)alert:(NSString* _Nullable)msg sender:(id _Nullable)sender;


/// 多选项Alert
/// @param style Alert 或者 ActionSheet
/// @param selections 选项数组
/// @param config 显示前配置Block
/// @param sender  触发控件
- (AnyPromise*)alert:(UIAlertControllerStyle)style
          selections:(NSArray<NSString*>*)selections
              config:(void (^ _Nullable)(UIAlertController* _Nonnull))config
              sender:(id _Nullable)sender;

/// 带一个输入框的Alert
/// @param msg 信息
/// @param placeholder 占位提示
/// @param sender 触发控件
- (AnyPromise*)alert:(NSString* _Nullable)msg input:(NSString*)placeholder sender:(id _Nullable)sender;


/// 带两个输入框的Alert
/// @param msg 信息
/// @param placeholder 占位提示
/// @param placeholder2 占位提示
/// @param sender 触发控件
- (AnyPromise*)alert:(NSString* _Nullable)msg input:(NSString*)placeholder input:(NSString* _Nullable)placeholder2  sender:(id _Nullable)sender;


/// 带输入框的可配置Alert
/// @param msg 信息
/// @param placeholder 占位提示
/// @param placeholder2 占位提示
/// @param config 配置Block
/// @param sender 触发控件
- (AnyPromise *)alert:(NSString * _Nullable)msg input:(NSString * _Nullable)placeholder input:(NSString * _Nullable)placeholder2 config:(void (^ _Nullable)(UIAlertController * _Nullable))config sender:(id _Nullable)sender;

@end

typedef enum : NSUInteger {
    VB_ComponentTypeHUD_ProtocolStyleDark,
    VB_ComponentTypeHUD_ProtocolStyleLight,
    VB_ComponentTypeHUD_ProtocolStyleDefault,
} VB_ComponentTypeHUD_ProtocolStyle;

@protocol VB_ComponentTypeHUD_Protocol <NSObject>

@property (nonatomic, assign) NSTimeInterval showTimeinterval;
@property (nonatomic, assign) VB_ComponentTypeHUD_ProtocolStyle style;

- (void)show:(NSString*)msg;
- (void)success:(NSString*)msg;
- (void)wait:(NSString*)msg;
- (void)dismiss;

@end

typedef enum : NSUInteger {
    VBPopupTypeForm,
    VBPopupTypeBottom,
} VBPopupType;

@protocol VB_ComponentTypePopup_Protocol <NSObject>

- (void)popup:(__kindof UIViewController*)vc;
- (void)popup:(__kindof UIViewController *)vc completion:(nullable void (^)(void))completion;
- (void)popdown;
- (void)popdown:(nullable void (^)(void))completion;

- (AnyPromise*)popupPromise:(__kindof UIViewController*)vc;
- (AnyPromise*)popdownPromise;

@property (nonatomic, assign) VBPopupType style;
@property (nonatomic, assign) BOOL navigationBarHidden;
@property (nonatomic, assign) BOOL toolBarHidden;
@property (nonatomic, assign) BOOL clickBgClose;

@end

@protocol VB_ComponentTypePicker_Protocol <NSObject>
- (AnyPromise*)picker;
- (AnyPromise*)pickerWithArray:(NSArray<NSString*>*)array;
- (AnyPromise*)pickerWithArray:(NSArray<NSString*>*)array selected:(NSInteger)selected;
@end


@interface VB_Component : NSObject

@property (nonatomic, weak) __kindof VB_Presenter* _Nullable presenter;
@property (nonatomic, weak, readonly) __kindof VB_Interactor* interactor;

- (VB_ComponentType)type;

@end

NS_ASSUME_NONNULL_END
