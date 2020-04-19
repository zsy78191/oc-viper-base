//
//  VB_StandardListInteractor.h
//  demo
//
//  Created by 张超 on 2020/4/19.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_Interactor.h"

NS_ASSUME_NONNULL_BEGIN

@interface VB_StandardListInteractor : VB_Interactor

@property (nonatomic, strong) Class managedClass;
@property (nonatomic, strong) Class providerClass;

@end

NS_ASSUME_NONNULL_END
