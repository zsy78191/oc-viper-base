//
//  RPFontLoader.h
//  rework-reader
//
//  Created by 张超 on 2019/2/11.
//  Copyright © 2019 orzer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VB_Entity.h"

NS_ASSUME_NONNULL_BEGIN
@class AnyPromise;

@interface VB_ImportFontEntity : VB_Entity
@property (nonatomic, strong) NSMutableArray* importedFonts;
@end

@interface VB_Font : VB_Entity
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* file;
@end

@interface VB_FontLoader : NSObject

+ (NSArray* _Nullable)registerFontsAtPath:(NSString *)fontFilePath;

+ (AnyPromise*)autoRegistFont;
+ (AnyPromise*)unregistFont:(NSString*)file;

+ (AnyPromise*)fontsURL;
+ (AnyPromise*)importFont:(NSURL*)url;


+ (NSNumber*)fontSizeWithTextStyle:(UIFontTextStyle)style;


+ (NSArray* _Nullable)registerFontsAtPaths:(NSArray <NSURL*> *)fontFilePaths API_DEPRECATED_WITH_REPLACEMENT("registerFontsAtPath:", macos(10.6, 10.14), ios(4.1, 12.0), watchos(2.0, 5.0), tvos(9.0, 12.0));
+ (void)testShowAllFonts;
@end

NS_ASSUME_NONNULL_END
