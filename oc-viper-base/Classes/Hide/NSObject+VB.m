

//
//  NSObject+VB.m
//  viper-base
//
//  Created by 张超 on 2019/8/26.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "NSObject+VB.h"
@import ReactiveObjC;

void INN(id x,id this,void (^y)(id this,id data)) {
    if (x) {
        if (y) {
            y(this,x);
        }
    } else {
        NSLog(@"验证为nil");
    }
}

void IN(id x,id this, id (^iSNil)(void) ,void (^y)(id this,id data)) {
    if (x) {
        if (y) {
            y(this,x);
        }
    } else {
        if (iSNil) {
            iSNil();
        } else {
            NSLog(@"验证为nil2");
        }
    }
}

@implementation NSObject (VB)

- (void)binding:(id)obj keypath:(NSString *)path toKeypath:(NSString *)path2 {
    [[RACSubscriptingAssignmentTrampoline alloc] initWithTarget:self nilValue:nil][path2] = [obj rac_valuesForKeyPath:path observer:self];
}
 

@end
