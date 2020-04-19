//
//  NSObject+ocbase.h
//  oc-base
//
//  Created by 张超 on 2019/1/11.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (VB)

- (NSArray *)vb_propertysNameWithClass:(Class)c;
- (NSArray *)vb_propertysName;

- (NSArray *)vb_methodsWithClass:(Class)c;
- (NSArray *)vb_methods;

+ (NSArray *)vb_allClasses;
+ (NSArray *)vb_allClassesWithPrefix:(NSString* _Nullable)prefix;

+ (NSDictionary*)vb_propertyWithClass:(Class)c;

@end

NS_ASSUME_NONNULL_END
