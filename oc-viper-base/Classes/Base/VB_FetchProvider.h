//
//  VB_FetchProvider.h
//  viper-base
//
//  Created by 张超 on 2019/9/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_DataProvider.h"

NS_ASSUME_NONNULL_BEGIN


@interface VB_FetchProvider : VB_DataProvider {
    
}

@property (nonatomic, strong) NSString* className;
@property (nonatomic, weak) UITableView* tableView;

@end

NS_ASSUME_NONNULL_END
