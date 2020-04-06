//
//  VB_Interactor+DataTrans.m
//  ViperDevelopment
//
//  Created by 张超 on 2019/11/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Interactor+DataTrans.h"

@implementation VB_Interactor (DataTrans)

-(id _Nonnull (^)(NSString * _Nonnull))getData
{
    return ^ (NSString* name) {
        return [self valueForKeyPath:name];
    };
}

- (id)dataWithName:(NSString *)name
{
    return self.getData(name);
}

@end
