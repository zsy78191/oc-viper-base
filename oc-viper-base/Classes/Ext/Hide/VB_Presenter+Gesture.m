//
//  VB_Presenter+Gesture.m
//  viper-base
//
//  Created by 张超 on 2019/8/25.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_Presenter+Gesture.h"

@implementation VB_Presenter (Gesture)

- (UITapGestureRecognizer *)tapGesture
{
    UITapGestureRecognizer* t = [[UITapGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:t];
    t.numberOfTapsRequired = 1;
    return t;
}

@end
