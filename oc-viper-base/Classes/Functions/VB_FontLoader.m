
//
//  RPFontLoader.m
//  rework-reader
//
//  Created by 张超 on 2019/2/11.
//  Copyright © 2019 orzer. All rights reserved.
//

#import "VB_FontLoader.h"
#import "VB_CollectionChange.h"
@import CoreText;
@import PromiseKit;

@implementation VB_ImportFontEntity
- (NSMutableArray *)importedFonts
{
    if (!_importedFonts) {
        _importedFonts = [NSMutableArray arrayWithCapacity:10];
    }
    return _importedFonts;
}
@end

@implementation VB_Font
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

+ (AnyPromise *)unregistFont:(NSString *)file
{
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        CFErrorRef cfDe_RegisterError;
        CTFontManagerUnregisterFontsForURL((__bridge CFURLRef)[NSURL fileURLWithPath:file], kCTFontManagerScopeNone, &cfDe_RegisterError);
        r(@YES);
    }];
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

+ (AnyPromise*)fontsURL {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver _Nonnull r) {
        NSURL* url = [[NSURL fileURLWithPath:[@"~/Documents" stringByExpandingTildeInPath]] URLByAppendingPathComponent:@"fonts"];
        BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
        if(!exist) {
         NSError* error;
         [[NSFileManager defaultManager] createDirectoryAtPath:[url path] withIntermediateDirectories:NO attributes:nil error:&error];
        }
        r(url);
    }];
}

+ (AnyPromise *)importFont:(NSURL *)url
{
    return [[self class] fontsURL]
    .then(^(NSURL* to) {
        NSString* fileName = [url lastPathComponent];
        NSError* e;
        NSURL* toURL = [to URLByAppendingPathComponent:fileName];
        [[NSFileManager defaultManager] copyItemAtURL:url toURL:toURL error:&e];
        if (e) {
            @throw e;
        }
        return toURL;
    });
}

+ (AnyPromise*)autoRegistFont
{
  return [[self class] fontsURL]
  .then(^ (NSURL* url){
        NSArray* content = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[url path] error:nil];
        NSMutableArray* array = [NSMutableArray array];
        [content enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString* l = [obj lowercaseString];
            if ([l hasSuffix:@"otf"] || [l hasSuffix:@"ttf"]) {
                NSString* file = [[url URLByAppendingPathComponent:obj] path];
                [array addObject:file];
            }
        }];
        return array;
    }).then(^ (NSArray* content) {
        NSMutableArray* final = [NSMutableArray array];
        [content enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray* t = [[self class] registerFontsAtPath:obj];
            if (t.count > 0) {
                VB_Font* font = [[VB_Font alloc] init];
                font.title = [t firstObject];
                font.file = obj;
                [final addObject:font];
            }
        }];
        return [final copy];
    });
}

@end
