//
//  VB_StandardListInteractor.m
//  demo
//
//  Created by 张超 on 2020/4/19.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "VB_StandardListInteractor.h"
#import "VB_Out_Header.h"
@import MagicalRecord;

@interface VB_StandardListInteractor ()
@property (nonatomic, strong) VB_FetchProvider* provider;
@end

@implementation VB_StandardListInteractor

- (VB_FetchProvider *)provider
{
    if (!_provider) {
        if (self.providerClass) {
            NSLog(@"Set provider class %@",self.providerClass);
            _provider = [[self.providerClass alloc] initWithEntityClass:self.managedClass];
        } else {
            _provider = [[VB_FetchProvider alloc] initWithEntityClass:self.managedClass];
        }
    }
    return _provider;
}



- (AnyPromise *)setupComponentPromise:(__kindof VB_Component *)component
{
    return [self ensure:component isKindOf:[VB_TableviewComponent class]]
    .then(^(VB_TableviewComponent* c) {
        c.dataSource = self.provider;
        return c;
    });
}

- (id)preloadData
{
    self.managedClass = self.presenter.needData(@"managedClass");
    self.providerClass = self.presenter.needData(@"providerClass");
    return @(1);
}

- (void)addNewItem:(id<RACSubscriber>)subscriber
{
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        NSManagedObject* c = [(id)self.managedClass MR_createEntityInContext:localContext];
        if([self.provider respondsToSelector:@selector(configBeforeInsertToDatabase:)]) {
            [self.provider configBeforeInsertToDatabase:c];
        }
    }];
    [subscriber sendCompleted];
}

- (void)tableViewDidDelete:(PMKResolver)resolver param:(NSIndexPath *)indexPath
{
    resolver(@1);
}

- (void)tableViewDidInsert:(PMKResolver)resolver param:(NSIndexPath *)indexPath
{
    resolver(@1);
}

- (void)tableViewDidSelect:(PMKResolver)resolver param:(id)param
{
    resolver(@NO);
}

@end
