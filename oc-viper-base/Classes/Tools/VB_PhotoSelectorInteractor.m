//
//  VB_PhotoSelectorInteractor.m
//  demo
//
//  Created by 张超 on 2020/5/15.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_PhotoSelectorInteractor.h"
#import "VB_Out_Header.h"
@import PhotosUI;

@interface VB_PhotoSelectorInteractor() <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) id <RACSubscriber> selectFileSubscriber;

@end

@implementation VB_PhotoSelectorInteractor

- (instancetype)init
{
    self = [super init];
    if (self) {
        @weakify(self);
        self.finishBlock = ^(id  _Nonnull img, id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            [self.presenter hudShow:@"VB_FileSelectorInteractor 没有设置 FinishBlock"];
            [subscriber sendCompleted];
        };
    }
    return self;
}

- (void)selectImg:(id<RACSubscriber>)subscriber param:(id)type
{
    UIImagePickerController* p = [[UIImagePickerController alloc] init];
    p.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self.presenter present:p];
    [p setDelegate:self];
    self.selectFileSubscriber = subscriber;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.selectFileSubscriber) {
        [self.selectFileSubscriber sendCompleted];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
  
    UIImage* image = info[UIImagePickerControllerOriginalImage];
    if (self.selectFileSubscriber) {
        [self.selectFileSubscriber sendNext:image];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
