//
//  VB_FetchProvider.m
//  viper-base
//
//  Created by 张超 on 2019/9/4.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_FetchProvider.h"
#import "VB_IndexPathEntity.h"
@import MagicalRecord;
//#import "EntityFavor+CoreDataClass.h"
//#import ""

@interface VB_FetchProvider () <NSFetchedResultsControllerDelegate>
{
    
}

@property (nonatomic, strong) NSFetchedResultsController* fetch;

@end

@implementation VB_FetchProvider

@synthesize useHeader,view;

- (NSFetchedResultsController *)fetch
{
    if (!_fetch) {
      _fetch = [(id)NSClassFromString(self.className) MR_fetchAllSortedBy:@"sort" ascending:YES withPredicate:nil groupBy:nil delegate:self];
    }
    return _fetch;
}

- (void)addObject:(__kindof VB_IndexPathEntity*)obj;
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

- (__kindof VB_IndexPathEntity*)objectAtIndexPath:(NSIndexPath*)path;
{
    VB_IndexPathEntity* v = [[VB_IndexPathEntity alloc] init];
    v.data = [self.fetch objectAtIndexPath:path];
    return v;
}


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


@end
