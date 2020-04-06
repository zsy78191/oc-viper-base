//
//  NSObject+ocbase.m
//  oc-base
//
//  Created by 张超 on 2019/1/11.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "NSObject+Runtime.h"
#import <ObjC/Runtime.h>
@import RegexKitLite;

@implementation NSObject (VB)

- (NSArray *)vb_propertysNameWithClass:(Class)c
{
    unsigned int count = 0;
    //获取属性的列表
    objc_property_t *propertyList =  class_copyPropertyList(c, &count);
    NSMutableArray *propertyArray = [NSMutableArray array];
    for(int i=0;i<count;i++)
    {
        //取出每一个属性
        objc_property_t property = propertyList[i];
        //获取每一个属性的变量名
        const char* propertyName = property_getName(property);
        NSString *proName = [[NSString alloc] initWithCString:propertyName encoding:NSUTF8StringEncoding];
        [propertyArray addObject:proName];
    }
    //c语言的函数，所以要去手动的去释放内存
    free(propertyList);
    return propertyArray.copy;
}

- (NSArray *)vb_propertysName
{
    return [self vb_propertysNameWithClass:[self class]];
}

#pragma mark - 获取类的所有方法
- (NSArray *)vb_methodsWithClass:(Class)c
{
    NSMutableArray *mutArr = [NSMutableArray array];
    unsigned int outCount;
    /** 第一个参数：要获取哪个类的方法
     * 第二个参数：获取到该类的方法的数量
     */
    Method *methodList = class_copyMethodList(c, &outCount);
    // 遍历所有属性列表
    for (int i = 0; i<outCount; i++) {
        SEL name = method_getName(methodList[i]);
        [mutArr addObject:NSStringFromSelector(name)];
    }
    return [NSArray arrayWithArray:mutArr];
}

- (NSArray *)vb_methods
{
    return [self vb_methodsWithClass:[self class]];
}

+ (NSArray*)vb_allClasses
{
    return [[self class] vb_allClassesWithPrefix:nil];
}


+ (NSArray*)vb_allClassesWithPrefix:(NSString* _Nullable)prefix
{
    int numClasses;
    Class *classes = NULL;
    
    classes = NULL;
    numClasses = objc_getClassList(NULL, 0);
    //    NSLog(@"Number of classes: %d", numClasses);
    NSMutableArray* a = [[NSMutableArray alloc] initWithCapacity:numClasses];
    if (numClasses > 0 )
    {
        classes = (__unsafe_unretained Class *)malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int i = 0; i < numClasses; i++) {
            //            NSLog(@"Class name: %s", class_getName(classes[i]));
            NSString* name = NSStringFromClass(classes[i]);
            if (prefix && [name hasPrefix:prefix]) {
                [a addObject:name];
            }
            else {
                [a addObject:name];
            }
        }
        free(classes);
    }
    return [a copy];
}

- (Class)vb_classForProperty:(NSString*)propertyName
{
    
    return nil;
}

+ (NSDictionary*)vb_propertyWithClass:(Class)c {
    unsigned int count = 0;
    //获取属性的列表
    objc_property_t *propertyList =  class_copyPropertyList(c, &count);
    NSMutableDictionary *propertyArray = [NSMutableDictionary dictionary];
    for(int i=0;i<count;i++)
    {
        //取出每一个属性
        objc_property_t property = propertyList[i];
        //获取每一个属性的变量名
        const char* propertyName = property_getName(property);
        NSString *proName = [[NSString alloc] initWithCString:propertyName encoding:NSUTF8StringEncoding];
        
        objc_property_attribute_t* proertyAttr = property_copyAttributeList(property, 0);
        NSString *proAttr = [[NSString alloc] initWithCString:proertyAttr->value encoding:NSUTF8StringEncoding];
               
        [propertyArray setValue:[proAttr stringByMatching:@"(?<=@\\\").*(?=\\\")"] forKey:proName];
    }
    //c语言的函数，所以要去手动的去释放内存
    free(propertyList);
    return propertyArray.copy;
}

@end
