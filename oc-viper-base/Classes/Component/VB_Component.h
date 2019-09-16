//
//  VB_Component.h
//  viper-base
//
//  Created by 张超 on 2019/8/28.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VB_Interactor, VB_Presenter, VB_DataProvider, AnyPromise, VBCollectionChange;

typedef enum : NSUInteger {
    VB_ComponentTypeView,
    VB_ComponentTypeAlert,
    VB_ComponentTypeHUD,
    VB_ComponentTypePopup,
} VB_ComponentType;

NS_ASSUME_NONNULL_BEGIN

@protocol VB_ComponentTypeView_Protocol <NSObject>

- (__kindof UIView* _Nullable)managedView;
- (__kindof UIView*) mainView;
@property (nonatomic, assign) BOOL fullSize;
- (void)reloadData;
@property (nonatomic, weak) __kindof VB_DataProvider* _Nullable dataSource;
- (void)applyChanges:(VBCollectionChange* _Nullable)changes;

@end

@protocol VB_ComponentTypeAlert_Protocol <NSObject>
- (AnyPromise*)alert:(NSString*)msg sender:(id _Nullable)sender;
- (AnyPromise*)alert:(UIAlertControllerStyle)style
          selections:(NSArray<NSString*>*)selections
              config:(void (^)(UIAlertController*))config
              sender:(id _Nullable)sender;
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


@interface VB_Component : NSObject

@property (nonatomic, weak) __kindof VB_Presenter* _Nullable presenter;
@property (nonatomic, weak, readonly) __kindof VB_Interactor* interactor;

- (VB_ComponentType)type;

@end

NS_ASSUME_NONNULL_END
