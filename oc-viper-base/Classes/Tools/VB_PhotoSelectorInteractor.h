//
//  VB_PhotoSelectorInteractor.h
//  demo
//
//  Created by 张超 on 2020/5/15.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Interactor.h"
@protocol RACSubscriber;
NS_ASSUME_NONNULL_BEGIN

@interface VB_PhotoSelectorInteractor : VB_Interactor
- (void)selectImg:(id<RACSubscriber>)subscriber param:(id)type;
@property (nonatomic, strong) void (^ finishBlock)(id img, id<RACSubscriber> subscriber);
@end

NS_ASSUME_NONNULL_END
