//
//  demoTests.m
//  demoTests
//
//  Created by 张超 on 2020/4/19.
//  Copyright © 2020 orzer. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EntityItem+CoreDataClass.h"
@import MagicalRecord;
@interface demoTests : XCTestCase

@end

@implementation demoTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSInteger c = [EntityItem MR_countOfEntities];
    NSLog(@"||| %@",@(c));
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end