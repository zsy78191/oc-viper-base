//
//  VB_Header.h
//  viper-base
//
//  Created by 张超 on 2019/8/23.
//  Copyright © 2019 orzer. All rights reserved.
//

#ifndef VB_Header_h
#define VB_Header_h

#import <UIKit/UIKit.h>
@import ReactiveObjC;
@import PromiseKit;

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* VB_Header_h */
