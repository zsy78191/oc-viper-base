//
//  NSObject+VB.h
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void INN(id x,id this,void (^y)(id this,id data));
void IN(id x,id this, id (^iSNil)(void) ,void (^y)(id this,id data));

@interface NSObject (VB2) {
    
}

- (void)binding:(id)obj keypath:(NSString*)path toKeypath:(NSString*)path2;

@end

NS_ASSUME_NONNULL_END
