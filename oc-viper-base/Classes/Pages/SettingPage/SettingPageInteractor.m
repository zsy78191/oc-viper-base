//
//  SettingPageInteractor.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/25.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SettingPageInteractor.h"
#import "VBSettingEntityProtocal.h"
#import "NSObject+Runtime.h"
#import "SettingItemEntity.h"
#import "VB_Out_Header.h"
@import ObjectiveC;

@interface SettingPageInteractor ()
@property (nonatomic, weak) id<VBSettingEntityProtocal> entity;
@property (nonatomic, strong) VB_ArrayProvider* dataSource;
@end

@implementation SettingPageInteractor

- (VB_ArrayProvider *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[VB_ArrayProvider alloc] init];
    }
    return _dataSource;
}

- (void)setupComponent:(__kindof VB_Component *)component
{
    if ([component isKindOfClass:[VB_TableviewComponent class]]) {
        [(VB_TableviewComponent*)component setDataSource:self.dataSource];
    }
}


- (id)setupEntity:(PMKResolver _Nonnull)r param:(id<VBSettingEntityProtocal>)entity
{
    self.entity = entity;
    
//    NSDictionary* propertyClass = [NSObject vb_propertyWithClass:[entity class]];
//    NSLog(@"%@",propertyClass);
    [[(id)self.entity vb_propertysName] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
//        id value =  [(id)self.entity valueForKey:obj];
        
        SettingItemEntity* e = [[SettingItemEntity alloc] init];
        e.title = [self.entity titleForKey:obj];
        e.identifier = @"SettingCellTitle";
        e.keyString = obj;
        
        e.type = [entity typeForKey:obj];
        
        switch (e.type) {
            case SettingItemTypeText:
                e.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            case SettingItemTypeNumber:
                e.identifier = @"SettingCellNumber";
                e.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            case SettingItemTypeSwitch:
                e.identifier = @"SettingCellSwitch";
                e.selectionStyle = UITableViewCellSelectionStyleNone;
                break;
            case SettingItemTypePicker:
                e.identifier = @"SettingCellTitle";
                e.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                break;
            default:
                break;
        }
        
        
        NSString* icon = [self.entity iconForKey:obj];
        if (icon) {
            e.icon = icon;
        }
        
        [entity configItem:e];
        
        RACChannelTo(e,value) = [[RACKVOChannel alloc] initWithTarget:entity keyPath:obj nilValue:nil][@keypath(RACKVOChannel.new, followingTerminal)];
        
        [self.dataSource addObject:e];
        
        NSString* des =  [self.entity descriptionForKey:obj];
        if (des) {
            SettingItemEntity* other = [[SettingItemEntity alloc] init];
            other.type = SettingItemTypeNoUse;
            other.selectionStyle = UITableViewCellSelectionStyleNone;
            other.identifier = @"SettingCellDescription";
            other.title = des;
            [self.dataSource addObject:other];
        }
    }];
    return @(YES);
}

- (void)tableViewDidSelect:(PMKResolver)resolver param:(id)param
{
    SettingItemEntity* e = [self.dataSource objectAtIndexPath:param];
    switch (e.type) {
        case SettingItemTypeText:
        {
            [self handleText:e resolver:resolver];
            break;
        }
        case SettingItemTypeNumber:
        {
            resolver(@NO);
            break;
        }
        case SettingItemTypePicker:
        {
            [self handlePicker:e resolver:resolver];
            break;
        }
        default:
            resolver(@NO);
            break;
    }
}

- (void)handleText:(SettingItemEntity*)e resolver:(PMKResolver)resolver
{
  [[self presenter] alert:nil input:[e title] input:nil config:^(UIAlertController * _Nonnull alert) {
      [[alert.textFields firstObject] setText:[e.value description]];
      if (e.value) {
          if ([e.value isKindOfClass:[NSString class]]) {
              
          } else if([e.value isKindOfClass:[NSNumber class]]) {
              [[alert.textFields lastObject] setKeyboardType:UIKeyboardTypeDecimalPad];
          }
      }
  } sender:nil]
  .then(^(NSArray* data) {
      if (data) {
          e.value = [data lastObject];
      }
      resolver(@YES);
  });
}

- (void)handleNumber:(SettingItemEntity*)e resolver:(PMKResolver)resolver {
    
}

- (void)handlePicker:(SettingItemEntity*)e resolver:(PMKResolver)resolver {
    NSUInteger selected = 0;
    if (!e.selections) {
        selected = 0;
    } else {
        if ([e.selections indexOfObject:e.value] == kCFNotFound) {
            selected = 0;
        } else {
            selected = [e.selections indexOfObject:e.value];
        }
    }
    
    [self.presenter pickerWithArray:e.selections selected:selected].then(^(id value){
        if(value) {
             e.value = e.selections[[value integerValue]];
        }
        resolver(value);
    });
}



 
@end
