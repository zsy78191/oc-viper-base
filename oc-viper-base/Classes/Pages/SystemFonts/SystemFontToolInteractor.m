//
//  PageOneInteractor.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/22.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SystemFontToolInteractor.h"
#import "CustomCellEntity.h"
#import "SystemFontToolPresenter.h"
#import "VB_FileSelectorInteractor.h"

@interface SystemFontToolInteractor ()
{
    
}
@property (nonatomic, assign) BOOL isSub;
@property (nonatomic, strong) VB_FileSelectorInteractor* fileSelector;

@end

@implementation SystemFontToolInteractor

- (VB_FileSelectorInteractor *)fileSelector
{
    if (!_fileSelector) {
        _fileSelector = [[VB_FileSelectorInteractor alloc] init];
        _fileSelector.parentInteractor = self;
    }
    return _fileSelector;
}

- (VB_ArrayProvider *)dataSource
{
    if (!_dataSource) {
        _dataSource = [[VB_ArrayProvider alloc] init];
    }
    return _dataSource;
}

- (void)setupComponent:(__kindof VB_Component *)component
{
    if (component.type == VB_ComponentTypeView) {
        id <VB_ComponentTypeView_Protocol> viewcompont = component;
        viewcompont.dataSource = self.dataSource;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id) preLoad {
    if (self.presenter.needData) {
       NSString* family = self.presenter.needData(@"family");
       if (family) {
           self.presenter.title = family;
           self.isSub = YES;
           [self loadFontWithFamily:family];
       } else {
           [self loadFontFamily];
       }
   } else {
       [self loadFontFamily];
   }
   return @(YES);
}

- (CustomCellEntity*)customEntity
{
    CustomCellEntity* entity = [[CustomCellEntity alloc] init];
    entity.presenterClassName = @"SystemFontToolPresenter";
    entity.identifier = @"FontChildCell";
    entity.icon = @"tray.full";
    entity.presentType = VBPresentTypePush;
    return entity;
}

- (void)loadFontWithFamily:(NSString*)family
{
    if ([family isEqualToString:@"用户导入字体"]) {
        [VB_Router globalEntityForKey:@"fonts"].thenInBackground(^(VB_ImportFontEntity*font) {
            NSMutableArray* a = [[NSMutableArray alloc] init];
            [font.importedFonts enumerateObjectsUsingBlock:^(VB_Font * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              [a addObject:({
                 CustomCellEntity* entity = [self customEntity];
                 entity.title = obj.title;
                 entity.detial = [obj.file lastPathComponent];
                 entity;
              })];
            }];
            return a;
        }).then(^(NSArray* datas){
            dispatch_async(dispatch_get_main_queue(), ^{
               [self.dataSource addObjects:datas];
            });
        });
    } else {
        [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
              r(@YES);
          }].thenInBackground(^{
              NSMutableArray* a = [[NSMutableArray alloc] init];
              NSArray* fonts = [[UIFont fontNamesForFamilyName:family] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
              [fonts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [a addObject:({
                   CustomCellEntity* entity = [self customEntity];
                   entity.title = obj;
                   entity;
                })];
              }];
              return a;
          }).then(^(NSArray* datas){
              dispatch_async(dispatch_get_main_queue(), ^{
                 [self.dataSource addObjects:datas];
              });
          });
    }
}

- (AnyPromise*) createFirst {
    return [VB_Router globalEntityForKey:@"fonts"].then(^(VB_ImportFontEntity*font) {
        if (font.importedFonts.count == 0) {
            return @[];
        }
        CustomCellEntity* entity = [self customEntity];
        entity.identifier = @"FontCell";
        entity.title = @"用户导入字体";
        entity.detial = [NSString stringWithFormat:@"包含%@款字体",@(font.importedFonts.count)];
        return @[entity];
    });
}

- (void)loadFontFamily
{
    [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
          r(@YES);
      }].thenInBackground(^{
          NSMutableArray* a = [[NSMutableArray alloc] init];
          NSArray* fonts = [[UIFont familyNames] sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES]]];
          [fonts enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              [a addObject:({
                 CustomCellEntity* entity = [self customEntity];
                 entity.identifier = @"FontCell";
                 entity.title = obj;
                 entity.detial = [NSString stringWithFormat:@"包含%@款字体",@([UIFont fontNamesForFamilyName:obj].count)];
                 entity;
              })];
          }];
          return [self createFirst].then(^(NSArray* en) {
              if (en.count > 0) {
                   [a insertObjects:en atIndexes:[NSIndexSet indexSetWithIndex:0]];
              }
              return a;
          });
      }).then(^(NSArray* datas){
          [self.dataSource addObjects:datas];
      }).catch(^(NSError* e) {
          NSLog(@"%@",e);
      });
}

- (void)setFilterString:(PMKResolver)r param:(NSString *)str
{
    if (!str || str.length == 0) {
        [self.dataSource setPredicate:nil];
    } else {
        NSString* pstr = [NSString stringWithFormat:@"title like[cd] '*%@*'", str];
        NSPredicate* p = [NSPredicate predicateWithFormat:pstr];
        [self.dataSource setPredicate:p];
    }
    
    [self.presenter promiseWithName:@"reloadData"];
}

- (void)tableViewDidSelect:(PMKResolver)resolver param:(id)param
{
    if (self.isSub) {
        CustomCellEntity* item = [self.dataSource objectAtIndexPath:param];
//        [[UIPasteboard generalPasteboard] setString:item.title];
//        [[self presenter] hudSuccess:[item.title stringByAppendingFormat:@"已拷贝到剪切板"]];
//        [[self presenter] popToRoot];
        [self.presenter promiseWithName:@"ensure" param:item];
        resolver(@YES);
    } else {
        CustomCellEntity* item = [self.dataSource objectAtIndexPath:param];
        SystemFontToolPresenter* subFontPresenter = [[SystemFontToolPresenter alloc] init];
        [subFontPresenter setNeedData:^id _Nonnull(NSString * _Nonnull key) {
            if ([key isEqualToString:@"family"]) {
                return item.title;
            } else if ([key isEqualToString:@"needSearchBar"]) {
                return @(NO);
            }
            return nil;
        }];
        
        BOOL b = [[self presenter] isSearchViewControllerResult];
        if (b) {
            [[[self presenter] parentPresenter] push:subFontPresenter];
        } else {
           [[self presenter] push:subFontPresenter];
        }
        resolver(@YES);
    }
}

- (void)importFonts:(id<RACSubscriber>)subscriber sender:(id)sender
{
    [self.fileSelector selectFileWithUTIs:@[@"public.font"]]
    .then(^(NSString* file){
        if (!file) {
            @throw [NSError errorWithDomain:@"FonteLoader" code:-102 userInfo:@{NSLocalizedDescriptionKey:@"没有选择文件"}];
        }
        return [VB_FontLoader importFont:[NSURL fileURLWithPath:file]];
    }).then(^ (NSURL* url) {
         [self.presenter hudSuccess:@"拷贝成功"];
        VB_Font* f = [[VB_Font alloc] init];
        f.title = [VB_FontLoader registerFontsAtPath:url.path].firstObject;
        f.file = url.path;
         return  f;
    }).then(^ (VB_Font* f){
        VB_ImportFontEntity* font = [VB_Router entityForKey:@"fonts"];
        if(font) {
            [font.importedFonts addObject:f];
        }
    }).then(^{
        [[self dataSource] removeAllObjects];
        [self loadFontFamily];
        [subscriber sendCompleted];
    }).catch(^ (NSError* e) {
        if (e.code != -102) {
            NSString* des = [e localizedDescription];
            if (e.code == 516) {
                des = NSLocalizedString(@"字体已经导入", nil);
            }
            [self.presenter alert:UIAlertControllerStyleAlert selections:@[NSLocalizedString(@"重新选择",nil)] config:^(UIAlertController * _Nonnull a) {
                a.message = des;
                a.title = NSLocalizedString(@"提示",nil);
            } sender:nil]
             .then(^(id x) {
                 if ([x integerValue] == 2) {
                     [self importFonts:subscriber sender:sender];
                 } else {
                     [subscriber sendCompleted];
                 }
            });
        } else {
            [subscriber sendCompleted];
        }
    });
}

- (void)tableViewDidDelete:(PMKResolver)resolver param:(NSIndexPath *)indexPath
{
    [self.presenter hudWait:@"请稍等"];
    CustomCellEntity* obj = [self.dataSource objectAtIndexPath:indexPath];
    [VB_Router globalEntityForKey:@"fonts"].then(^(VB_ImportFontEntity*font) {
        __block VB_Font* f = nil;
        [font.importedFonts enumerateObjectsUsingBlock:^(VB_Font*  _Nonnull obj2, NSUInteger idx, BOOL * _Nonnull stop) {
            if([obj2.title isEqualToString:obj.title]) {
                f = obj2;
                *stop = YES;
            }
        }];
        
        [font.importedFonts removeObject:f];
        return [VB_FontLoader unregistFont:f.file].then(^{
             return f;
        });
    }).then(^ (VB_Font* obj) {
        NSFileManager* fm = [NSFileManager defaultManager];
        if ([fm fileExistsAtPath:obj.file]) {
            NSError* error;
            BOOL deleteFile = [fm removeItemAtPath:obj.file error:&error];
            if (!deleteFile) {
                [self.presenter hudShow:@"删除字体文件失败"];
                resolver(error);
            } else {
               [self.presenter hudWait:@"删除文件"];
            }
        } else {
            [self.presenter hudWait:@"文件不存在"];
        }
    }).then(^ {
        [self.dataSource removeObject:obj];
        [[self presenter] hudSuccess:@"删除成功"];
        resolver(@YES);
    });
}



@end
