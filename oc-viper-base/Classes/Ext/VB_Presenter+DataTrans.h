//
//  VB_Presenter+DataTrans.h
//  ViperDevelopment
//
//  Created by 张超 on 2019/11/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Presenter.h"
@class AnyPromise;

NS_ASSUME_NONNULL_BEGIN

@interface VB_Presenter (DataTrans)

@property (nonatomic, strong) AnyPromise* (^loadData)(NSString* key);
@property (nonatomic, strong, readonly) _Nullable id (^getData)(NSString* key);

@end

NS_ASSUME_NONNULL_END
