//
//  DemoInteractorSix.m
//  viper-base
//
//  Created by 张超 on 2019/9/9.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_FileSelectorInteractor.h"
#import "VB_Out_Header.h"

@interface VB_FileSelectorInteractor () <UIDocumentPickerDelegate>
{
    
}
@property (nonatomic, strong) id <RACSubscriber> selectFontSubscriber;
@end

@implementation VB_FileSelectorInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        self.finishBlock = ^(NSString * _Nonnull file, id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            [self.presenter hudShow:@"VB_FileSelectorInteractor 没有设置 FinishBlock"];
            [subscriber sendCompleted];
        };
    }
    return self;
}

- (void)selectFont:(id<RACSubscriber>)subscriber param:(id)type
{
    UIDocumentPickerViewController* d = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[type] inMode:UIDocumentPickerModeImport];
    [self.presenter present:d];
    [d setDelegate:self];
    self.selectFontSubscriber = subscriber;
}

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller
{
    [self.selectFontSubscriber sendCompleted];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray<NSURL *> *)urls
{
//    NSLog(@"%@",urls);
    if (urls.count == 0) {
        [self.selectFontSubscriber sendCompleted];
    } else {
        [urls enumerateObjectsUsingBlock:^(NSURL * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* filename = [obj lastPathComponent];
            NSURL* copyurl = [[NSURL fileURLWithPath:[@"~/Documents" stringByExpandingTildeInPath]] URLByAppendingPathComponent:filename];
            //        NSLog(@"%@",copyurl);
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:[copyurl path]]) {
                [[NSFileManager defaultManager] removeItemAtURL:copyurl error:nil];
            }
            NSError* error;
            BOOL copy = [[NSFileManager defaultManager] copyItemAtURL:obj toURL:copyurl error:&error];
            if (!copy) {
                [self.selectFontSubscriber sendError:error];
                [self.selectFontSubscriber sendCompleted];
            } else {
//                NSLog(@"%@",[copyurl path]);
//                BOOL regist = [RPFontLoader registerFontsAtPath:[copyurl path]];
//                NSLog(@"%@",@(regist));
                
//                [RPFontLoader testShowAllFonts];
//                [self.selectFontSubscriber sendCompleted];
                if (self.finishBlock) {
                    self.finishBlock([copyurl path], self.selectFontSubscriber);
                } else {
                    [self.selectFontSubscriber sendCompleted];
                }
            }
        }];
    }
}

@end
