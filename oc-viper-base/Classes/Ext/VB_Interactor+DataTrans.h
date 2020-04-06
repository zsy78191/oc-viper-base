//
//  VB_Interactor+DataTrans.h
//  ViperDevelopment
//
//  Created by 张超 on 2019/11/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Interactor.h"

NS_ASSUME_NONNULL_BEGIN

@interface VB_Interactor (DataTrans)

- (id)dataWithName:(NSString*)name;
@property (nonatomic, strong, readonly) id (^getData)(NSString* name);

@end

NS_ASSUME_NONNULL_END
