//
//  SettingEntity.m
//  ViperDevelopment
//
//  Created by 张超 on 2020/3/25.
//  Copyright © 2020 orzer. All rights reserved.
//

#import "SettingEntity.h"
#import "NSObject+Runtime.h"
@interface SettingEntity ()
{
    
}
@property (nonatomic, strong) NSDictionary* titleDict;
@property (nonatomic, strong) NSDictionary* descriptionDict;
@property (nonatomic, strong) NSDictionary* iconDict;
@property (nonatomic, strong) NSDictionary* identifierDict;

@property (nonatomic, assign) BOOL needUpdateUserDefault;

@property (nonatomic, strong) id observer;
@end

@implementation SettingEntity

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.needUpdateUserDefault = NO;
        [[self vb_propertysName] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           id userDefaultKey = [self identifierForKey:obj];
           if (userDefaultKey) {
               id value = [[NSUserDefaults standardUserDefaults] valueForKey:userDefaultKey];
               if (value) {
                 [self setValue:value forKey:obj];
               }
           }
        }];
        __weak typeof(self) ws = self;
        self.observer = [[NSNotificationCenter defaultCenter] addObserverForName:NSUserDefaultsDidChangeNotification object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification * _Nonnull note) {
//            NSLog(@"%@",note);
            ws.needUpdateUserDefault = NO;
            NSUserDefaults* d = note.object;
            [[ws vb_propertysName] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                id userDefaultKey = [ws identifierForKey:obj];
                if (userDefaultKey) {
                    [ws setValue:[d valueForKey:userDefaultKey] forKey:obj];
                }
            }];
            ws.needUpdateUserDefault = YES;
        }];
//        NSUserDefaultsDidChangeNotification
        self.needUpdateUserDefault = YES;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self.observer];
}

- (NSDictionary *)titleDict
{
    if (!_titleDict) {
        if ([self respondsToSelector:@selector(dictForTitle)]) {
            _titleDict = [self dictForTitle];
        }
    }
    return _titleDict;
}


- (NSDictionary *)descriptionDict
{
    if (!_descriptionDict) {
        if ([self respondsToSelector:@selector(dictForDescription)]) {
            _descriptionDict = [self dictForDescription];
        }
    }
    return _descriptionDict;
}



- (NSDictionary *)iconDict
{
    if (!_iconDict) {
        if ([self respondsToSelector:@selector(dictForIcon)]) {
            _iconDict = [self dictForIcon];
        }
    }
    return _iconDict;
}

- (NSDictionary *)identifierDict
{
    if (!_identifierDict) {
        if ([self respondsToSelector:@selector(dictForUserDefaultIndentifer)]) {
            _identifierDict = [self dictForUserDefaultIndentifer];
        }
    }
    return _identifierDict;
}


- (NSString *)titleForKey:(NSString *)key
{
    return [self.titleDict valueForKey:key];
}

- (NSString *)descriptionForKey:(NSString *)key
{
    return [self.descriptionDict valueForKey:key];
}

- (NSString *)iconForKey:(NSString *)key
{
    return [self.iconDict valueForKey:key];
}

- (NSString *)identifierForKey:(NSString *)key
{
    return [self.identifierDict valueForKey:key];
}

- (NSDictionary *)dictForIcon
{
    return nil;
}

- (NSDictionary *)dictForDescription
{
    return nil;
}

- (NSDictionary *)dictForTitle {
    return nil;
}

- (NSDictionary *)dictForUserDefaultIndentifer
{
    return nil;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if(! self.needUpdateUserDefault) return;
    id userDefaultKey = [self identifierForKey:key];
    if (userDefaultKey) {
        [[NSUserDefaults standardUserDefaults] setValue:value forKey:userDefaultKey];
    }
}

- (void)setNilValueForKey:(NSString *)key
{
    @try {
        [super setNilValueForKey:key];
    } @catch (NSException *exception) {
        NSLog(@"%@ %@",self,key);
    } @finally {
        
    }
}

- (SettingItemType)typeForKey:(NSString*) key {
    
    return SettingItemTypeText;
}

- (void)configItem:(SettingItemEntity *)item
{
    
}


@end
