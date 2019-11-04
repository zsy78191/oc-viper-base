//
//  VB_Presenter.m
//  viper-base
//
//  Created by 张超 on 2019/8/23.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Presenter.h"
#import "VB_Interactor.h"
#import "UIControl+VB.h"
#import "VB_Component.h"
@import Masonry;

@interface VB_Presenter ()
{
    __kindof VB_Interactor* _interactor;
}

@property (nonatomic, strong) VB_Component <VB_ComponentTypeAlert_Protocol>* alertComponent;
@property (nonatomic, strong) VB_Component <VB_ComponentTypeHUD_Protocol>* hudComponent;
@property (nonatomic, strong) VB_Component <VB_ComponentTypePopup_Protocol>* popupComponent;

@property (nonatomic, assign) BOOL originNavibarHidden;
@property (nonatomic, assign) BOOL originToolbarHidden;

@end

@implementation VB_Presenter

- (VB_Interactor *)interactor
{
    if (!_interactor) {
        Class c = [self interactorClass];
        NSAssert(c, @"%@设置的interactorClass 不存在",[self class]);
        _interactor = [[c alloc] init];
        _interactor.presenter = self;
    }
    return _interactor;
}

- (Class)interactorClass
{
    Class c = [VB_Interactor class];
    return c;
}

- (void)loadComponents
{
    
}

- (void)viewDidLoad {
    [self loadComponents];
    [super viewDidLoad];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)binding:(id)obj keypath:(NSString*)path toObj:(__kindof UIControl*)obj2 keypath:(NSString*)path2 {
    id v = [obj valueForKey:path];
    [[RACKVOChannel alloc] initWithTarget:obj keyPath:path nilValue:nil][@keypath(RACKVOChannel.new, followingTerminal)] =
    [obj2 vb_channelForControlEvents:UIControlEventValueChanged key:path2 nilValue:v];
    [obj2 setValue:v forKey:path2];
}

- (void)binding:(id)obj keypath:(NSString *)path toChannel:(RACChannelTerminal *)channel
{
    [[RACKVOChannel alloc] initWithTarget:obj keyPath:path nilValue:nil][@keypath(RACKVOChannel.new, followingTerminal)] = channel;
}

- (void)push:(__kindof UIViewController *)vc
{
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)present:(__kindof UIViewController *)vc
{
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (AnyPromise *)presentPromise:(__kindof UIViewController *)vc
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        [self presentViewController:vc animated:YES completion:^{
            r(vc);
        }];
    }];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissPresenter
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (AnyPromise *)dismissPromise;
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        [self.navigationController dismissViewControllerAnimated:YES completion:^{
            r(@1);
        }];
    }];
}

#pragma mark - component

- (void)setupComponent:(__kindof VB_Component *)component
{
    NSAssert(component, @"组件不能为nil");
    switch ([component type]) {
        case VB_ComponentTypeView:
        {
            id <VB_ComponentTypeView_Protocol> viewcomponent = component;
            UIView* superview = self.view;
            UIView* v = ({
                UIView* v = [viewcomponent managedView];
                
                if (viewcomponent.fullSize) {
                    v.frame = self.view.bounds;
                }
                v;
            });
            [self.view addSubview:v];
            
            UIEdgeInsets padding = UIEdgeInsetsMake(0,0,0,0);
            
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(superview.mas_top).with.offset(padding.top); //with is an optional semantic filler
                make.left.equalTo(superview.mas_left).with.offset(padding.left);
                make.bottom.equalTo(superview.mas_bottom).with.offset(-padding.bottom);
                make.right.equalTo(superview.mas_right).with.offset(-padding.right);
            }];
            component.presenter = self;
            [self.interactor setupComponent:viewcomponent];
            [viewcomponent reloadData];
            break;
        }
        case VB_ComponentTypeAlert:
        {
            component.presenter = self;
            self.alertComponent = component;
            break;
        }
        case VB_ComponentTypeHUD:
        {
            component.presenter = self;
            self.hudComponent = component;
            break;
        }
        case VB_ComponentTypePopup:
        {
            component.presenter = self;
            self.popupComponent = component;
            break;
        }
        default:
            break;
    }
}

- (AnyPromise*)alert:(NSString *)msg
{
    return [self alert:msg sender:nil];
}

- (AnyPromise *)alert:(UIAlertControllerStyle)style
           selections:(NSArray<NSString *> *)selections
               config:(void (^)(UIAlertController * _Nonnull))config
               sender:(nullable id)sender
{
    if (self.alertComponent) {
        return [self.alertComponent alert:style selections:selections config:config sender:sender];
    }
    return [self error:[NSString stringWithFormat:@"%@没有配置Alert组件",self]];
}

- (AnyPromise *)alert:(NSString *)msg sender:(id)sender
{
    if (self.alertComponent) {
        return [self.alertComponent alert:msg sender:sender];
    }
    return [self error:[NSString stringWithFormat:@"%@没有配置Alert组件",self]];
}

- (AnyPromise *)alert:(UIAlertControllerStyle)style
           selections:(NSArray<NSString *> *)selections
               config:(void (^)(UIAlertController * _Nonnull))config
{
   return [self alert:style selections:selections config:config sender:nil];
}


- (void)show:(NSString *)msg
{
    NSAssert(self.hudComponent,@"%@没有配置HUD组件",self);
    if (self.hudComponent) {
        [self.hudComponent show:msg];
    }
}

- (void)wait:(NSString *)msg
{
    NSAssert(self.hudComponent,@"%@没有配置HUD组件",self);
    if (self.hudComponent) {
        [self.hudComponent wait:msg];
    }
}

- (void)dismiss
{
    NSAssert(self.hudComponent,@"%@没有配置HUD组件",self);
    if (self.hudComponent) {
        [self.hudComponent dismiss];
    }
}

- (void)success:(NSString *)msg
{
    NSAssert(self.hudComponent,@"%@没有配置HUD组件",self);
    if (self.hudComponent) {
        [self.hudComponent success:msg];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self navigationController]) {
     
        self.originNavibarHidden = [[self navigationController] isNavigationBarHidden];
        
        self.originToolbarHidden = [[self navigationController] isToolbarHidden];
        
        switch (self.toolbarStyle) {
            case VBStyleUse:
                if (self.originToolbarHidden) {
                    [[self navigationController] setToolbarHidden:NO animated:NO];
                }
                break;
            case VBStyleNone:
                if (!self.originToolbarHidden) {
                    [[self navigationController] setToolbarHidden:YES animated:NO];
                }
                break;
            default:
                break;
        }
        
        switch (self.navibarStyle) {
            case VBStyleUse:
                if (self.originNavibarHidden) {
                    [[self navigationController] setNavigationBarHidden:NO animated:NO];
                }
                break;
            case VBStyleNone:
                if (!self.originNavibarHidden) {
                    [[self navigationController] setNavigationBarHidden:YES animated:NO];
                }
                break;
            default:
                break;
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    switch (self.toolbarStyle) {
        case VBStyleUse:
            if (self.originToolbarHidden) {
                [[self navigationController] setToolbarHidden:YES animated:NO];
            }
            break;
        case VBStyleNone:
            if (!self.originToolbarHidden) {
                [[self navigationController] setToolbarHidden:NO animated:NO];
            }
            break;
        default:
            break;
    }
    
    switch (self.navibarStyle) {
        case VBStyleUse:
            if (self.originNavibarHidden) {
                [[self navigationController] setNavigationBarHidden:YES animated:NO];
            }
            break;
        case VBStyleNone:
            if (!self.originNavibarHidden) {
                [[self navigationController] setNavigationBarHidden:NO animated:NO];
            }
            break;
        default:
            break;
    }
}


- (AnyPromise *)error:(NSString*)msg
{
    return [AnyPromise promiseWithValue:[NSError errorWithDomain:@"VBErrorDomain" code:201 userInfo:@{NSLocalizedDescriptionKey:msg}]];
}

- (void)popup:(__kindof UIViewController *)vc
{
    [self popup:vc config:nil];
}

- (void)popup:(__kindof UIViewController *)vc config:(void (^)(id<VB_ComponentTypePopup_Protocol> _Nonnull))config
{
    NSAssert(self.popupComponent,@"%@没有配置Popup组件",self);
    if (self.popupComponent) {
        if (config) {
            config(self.popupComponent);
        }
        [self.popupComponent popup:vc];
    }
}

- (AnyPromise *)popupPromise:(__kindof UIViewController *)vc config:(nullable void (^)(id<VB_ComponentTypePopup_Protocol> _Nonnull))config
{
    NSAssert(self.popupComponent,@"%@没有配置Popup组件",self);
    if (self.popupComponent) {
        if (config) {
            config(self.popupComponent);
        }
        return [self.popupComponent popupPromise:vc];
    }
    return nil;
}

- (AnyPromise *)popupPromise:(__kindof UIViewController *)vc
{
    return [self popupPromise:vc config:nil];
}

- (void)popdown
{
    NSAssert(self.popupComponent,@"%@没有配置Popup组件",self);
    if (self.popupComponent) {
        [self.popupComponent popdown];
    }
}

- (AnyPromise *)popdownPromise
{
    NSAssert(self.popupComponent,@"%@没有配置Popup组件",self);
    if (self.popupComponent) {
        return [self.popupComponent popdownPromise];
    }
    return nil;
}

- (void)dealloc
{
    NSLog(@"**** %@ %s",[self class],__func__);
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
}

@end
