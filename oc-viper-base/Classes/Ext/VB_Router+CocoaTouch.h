//
//  VB_Router+CocoaTouch.h
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/26.
//  Copyright © 2020 orzer. All rights reserved.
//
 
#import "VB_Router.h"

@class AnyPromise;

typedef enum : NSUInteger {
    SystemSchemeTypePrivacy = 0,
    SystemSchemeTypeWIFI,
    SystemSchemeTypeBluetooth,
    SystemSchemeTypeMOBILE_DATA_SETTINGS_ID,
    SystemSchemeTypeINTERNET_TETHERING,
    SystemSchemeTypeCarrier,
    SystemSchemeTypeNOTIFICATIONS_ID,
    SystemSchemeTypeGeneral,
    SystemSchemeTypeAbout,
    SystemSchemeTypeKeyboard,
    SystemSchemeTypeACCESSIBILITY,
    SystemSchemeTypeINTERNATIONAL,
    SystemSchemeTypeReset,
    SystemSchemeTypeWallpaper,
    SystemSchemeTypeSIRI,
    SystemSchemeTypeSAFARI,
    SystemSchemeTypeMUSIC,
    SystemSchemeTypeEQ,
    SystemSchemeTypePhotos,
    SystemSchemeTypeFACETIME
} SystemSchemeType;

NS_ASSUME_NONNULL_BEGIN

@interface VB_Router (CocoaTouch)

+ (AnyPromise*)systemSchemeJump:(SystemSchemeType)type;
+ (AnyPromise*)systemSchemeJumpSelf;


@end

NS_ASSUME_NONNULL_END
