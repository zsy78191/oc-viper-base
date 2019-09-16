//
//  DemoInteractorSix.h
//  viper-base
//
//  Created by 张超 on 2019/9/9.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Interactor.h"
@protocol RACSubscriber;
NS_ASSUME_NONNULL_BEGIN

@interface VB_FileSelectorInteractor : VB_Interactor
- (void)selectFont:(id<RACSubscriber>)subscriber param:(id)type;
@property (nonatomic, strong) void (^ finishBlock)(NSString* file, id<RACSubscriber> subscriber);
@end

NS_ASSUME_NONNULL_END
