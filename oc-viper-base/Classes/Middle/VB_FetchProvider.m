//
//  VB_FetchProvider.m
//  viper-base
//
//  Created by 张超 on 2019/9/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_FetchProvider.h"
#import "VB_IndexPathEntity.h"
#import "VB_TableviewComponent.h"
@import MagicalRecord;
//#import "EntityFavor+CoreDataClass.h"
//#import ""

@interface VB_FetchProvider () <NSFetchedResultsControllerDelegate>
{
    
}

@property (nonatomic, strong, readwrite) NSString* className;
@property (nonatomic, strong) NSFetchedResultsController* fetch;
@property (nonatomic, strong) NSMutableArray* reuseArray;

@end

@implementation VB_FetchProvider

- (NSMutableArray *)reuseArray
{
    if (!_reuseArray) {
        _reuseArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _reuseArray;
}

- (void)dealloc
{
    [self.reuseArray removeAllObjects];
}

@synthesize useHeader,view;

- (UITableView *)tableView
{
    return self.view.mainView;
}

- (instancetype)initWithEntityClass:(Class)entityClass
{
    self = [super init];
    if (self) {
        self.className = NSStringFromClass(entityClass);
    }
    return self;
}

- (NSFetchedResultsController *)fetch
{
    if (!_fetch) {
      _fetch = [(id)NSClassFromString(self.className) MR_fetchAllSortedBy:@"sort" ascending:YES withPredicate:nil groupBy:[self groupBy] delegate:self];
    }
    return _fetch;
}

- (NSString *)groupBy
{
    return nil;
}

- (void)addObject:(__kindof VB_IndexPathEntity*)obj;
{
    
}

- (void)addObjects:(NSArray *)objs
{
    
}

- (void)insertObject:(__kindof VB_IndexPathEntity*)obj at:(NSUInteger)idx;
{
    
}

- (void)removeObject:(__kindof VB_IndexPathEntity*)obj;
{
    
}

- (void)removeAllObjects;
{
    
}

- (__kindof VB_IndexPathEntity*)objectAtIndex:(NSUInteger)idx;
{
    return nil;
}

- (__kindof VB_IndexPathEntity*)pop;
{
    return nil;
}

- (void)push:(__kindof VB_IndexPathEntity*)obj;
{
    
}

- (NSUInteger)count;
{
    return [self.fetch fetchedObjects].count;
}

- (NSUInteger)sectionsCount
{
    return [self.fetch sections].count;
}

- (NSUInteger)countForSection:(NSUInteger)section
{
    id <NSFetchedResultsSectionInfo> info  = [[self.fetch sections] objectAtIndex:section];
    return info.numberOfObjects;
}

- (NSString *)titleForSection:(NSUInteger)section
{
    id <NSFetchedResultsSectionInfo> info  = [[self.fetch sections] objectAtIndex:section];
    return [info name];
    
}

- (__kindof VB_IndexPathEntity*)objectAtIndexPath:(NSIndexPath*)path;
{
    return [self entityWithOrigin:[self.fetch objectAtIndexPath:path]];
}

- (Class)indexPathEntityClass
{
    return [VB_IndexPathEntity class];
}

- (VB_IndexPathEntity *)entityWithOrigin:(id)entity
{
    VB_IndexPathEntity* v = [self.reuseArray firstObject];
    if(v) {
        [self.reuseArray removeObjectAtIndex:0];
    } else {
        v = [[[self indexPathEntityClass] alloc] init];
    }
    v.data = entity;
    return v;
}

- (void)reuseEntity:(VB_IndexPathEntity *)entity
{
    [self.reuseArray addObject:entity];
}
//
//- (UITableView *)tableView
//{
//    return [self.view mainView];
//}


#pragma mark - fetch

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
            case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
            case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
            case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
            case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
            case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            case NSFetchedResultsChangeMove:
           
            break;
            case NSFetchedResultsChangeUpdate:
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}

- (void)configBeforeInsertToDatabase:(__kindof NSManagedObject *)obj
{
    
}

@end
