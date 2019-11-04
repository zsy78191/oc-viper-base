
//
//  RPFontLoader.m
//  rework-reader
//
//  Created by 张超 on 2019/2/11.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_FontLoader.h"
#import "VBCollectionChange.h"
@import CoreText;

@implementation VB_ImportFontEntity
- (NSMutableArray *)importedFonts
{
    if (!_importedFonts) {
        _importedFonts = [NSMutableArray arrayWithCapacity:10];
    }
    return _importedFonts;
}
@end

@implementation VB_FontLoader

+ (NSArray*)registerFontsAtPath:(NSString *)fontFilePath
{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:fontFilePath] == YES)
    {
        [UIFont familyNames];//This is here for a bug where font registration API hangs for forever.
        
        //In case of TTF file update : Fonts are already registered, first de-register them from Font Manager
        CFErrorRef cfDe_RegisterError;
        CTFontManagerUnregisterFontsForURL((__bridge CFURLRef)[NSURL fileURLWithPath:fontFilePath], kCTFontManagerScopeNone, &cfDe_RegisterError);
        
        NSArray* old = [UIFont familyNames];
        NSMutableArray* oldall = [NSMutableArray arrayWithCapacity:1000];
        [old enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[UIFont fontNamesForFamilyName:obj] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [oldall addObject:obj];
            }];
        }];
        
        //finally register the fonts with Font Manager,
        CFErrorRef cfRegisterError;
        bool fontsRegistered = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)[NSURL fileURLWithPath:fontFilePath], kCTFontManagerScopeNone, &cfRegisterError);
        
        if (fontsRegistered) {
            
            NSArray* new = [UIFont familyNames];
            NSMutableArray* newall = [NSMutableArray arrayWithCapacity:1000];
            [new enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [[UIFont fontNamesForFamilyName:obj] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [newall addObject:obj];
                }];
            }];
            [newall removeObjectsInArray:oldall];
            return [newall copy];
        }
        
        return nil;
    }
    return nil;
}

+ (NSArray *)registerFontsAtPaths:(NSArray<NSURL *> *)fontFilePaths
{
    if (fontFilePaths.count == 0) {
        return nil;
    }
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSMutableArray* target = [NSMutableArray array];
    
    [fontFilePaths enumerateObjectsUsingBlock:^(NSURL * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([fileManager fileExistsAtPath:[obj path]] == YES)
        {
            [target addObject:obj];
        }
    }];
    
    [UIFont familyNames];//This is here for a bug where font registration API hangs for forever.

    //In case of TTF file update : Fonts are already registered, first de-register them from Font Manager
    CFArrayRef cfDe_RegisterError;
//    CTFontManagerUnregisterFontsForURL((__bridge CFURLRef)[NSURL fileURLWithPath:fontFilePath], kCTFontManagerScopeNone, &cfDe_RegisterError);
    CTFontManagerUnregisterFontsForURLs((__bridge CFArrayRef)target, kCTFontManagerScopeNone, &cfDe_RegisterError);
    
    NSArray* old = [UIFont familyNames];
    NSMutableArray* oldall = [NSMutableArray arrayWithCapacity:1000];
    [old enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[UIFont fontNamesForFamilyName:obj] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [oldall addObject:obj];
        }];
    }];
    
    //finally register the fonts with Font Manager,
    CFArrayRef cfRegisterError;
//    bool fontsRegistered = CTFontManagerRegisterFontsForURL((__bridge CFURLRef)[NSURL fileURLWithPath:fontFilePath], kCTFontManagerScopeNone, &cfRegisterError);
    
    bool fontsRegistered = CTFontManagerRegisterFontsForURLs((__bridge CFArrayRef)[target copy], kCTFontManagerScopeNone, &cfRegisterError);
//    NSLog(@"%@",target);
//    NSLog(@"%@",cfRegisterError);
    if (fontsRegistered) {
        
        NSArray* new = [UIFont familyNames];
        NSMutableArray* newall = [NSMutableArray arrayWithCapacity:1000];
        [new enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [[UIFont fontNamesForFamilyName:obj] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [newall addObject:obj];
            }];
        }];
        [newall removeObjectsInArray:oldall];
        return [newall copy];
    }
    
    return nil;
}

+ (void)testShowAllFonts
{
    [[UIFont familyNames] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"[family] %@ ----",obj);
        NSArray* a = [UIFont fontNamesForFamilyName:obj];
        NSLog(@"%@",a);
    }];
}

+ (NSNumber*)fontSizeWithTextStyle:(UIFontTextStyle)style
{
    UIFont *font = [UIFont preferredFontForTextStyle:style];
    UIFontDescriptor *ctFont = font.fontDescriptor;
    NSNumber *fontString = [ctFont objectForKey:@"NSFontSizeAttribute"];
    return fontString;
}

+ (NSArray*)autoRegistFont
{
    NSURL* url = [NSURL fileURLWithPath:[@"~/Documents" stringByExpandingTildeInPath]];
    NSArray* content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[url path] error:nil];
    NSMutableArray* array = [NSMutableArray array];
    [content enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString* l = [obj lowercaseString];
        if ([l hasSuffix:@"otf"] || [l hasSuffix:@"ttf"]) {
            NSString* file = [[url URLByAppendingPathComponent:obj] path];
//            NSArray* load = [[self class] registerFontsAtPath:[file path]];
//            NSLog(@"%@",load);
            [array addObject:file];
        }
    }];
    NSMutableArray* final = [NSMutableArray array];
//    return [[self class] registerFontsAtPaths:array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSArray* t = [[self class] registerFontsAtPath:obj];
        [final addObjectsFromArray:t];
    }];
    return [final copy];
}

@end
