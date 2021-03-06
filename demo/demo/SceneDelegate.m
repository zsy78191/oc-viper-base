#import "SceneDelegate.h"
#import "VB_Out_Header.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    self.window.backgroundColor = [UIColor systemBackgroundColor];
    
    [self loadExtraFonts];
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


/// 加载额外的字体，首先注册全局变量，然后加载字体，最后记录字体

- (void)loadExtraFonts2 {
    
    VB_Router.registTransactionPromise
    .then(^(VB_Router* router){
        VB_ImportFontEntity* model = [[VB_ImportFontEntity alloc] init];
        [router bind:@"fonts" entity:model];
        return [VB_FontLoader autoRegistFont];
    }).then(^(NSArray* fonts){
        return [VB_Router globalEntityForKey:@"fonts"]
        .then(^(VB_ImportFontEntity*font) {
            [font.importedFonts addObjectsFromArray:fonts];
            return @(font.importedFonts.count);
        });
    }).then(^(id num) {
        NSLog(@"加载了%@个字体",num);
    }).catch(^(NSException* e) {
        NSLog(@"%@",e);
    });
}

- (void)loadExtraFonts {
    
    VB_ImportFontEntity* model = [[VB_ImportFontEntity alloc] init];
    [VB_Router bind:@"fonts" entity:model].then(^ {
        return [VB_FontLoader autoRegistFont];
    }).then(^(NSArray* fonts){
        [model.importedFonts addObjectsFromArray:fonts];
        return @(model.importedFonts.count);
    }).then(^(id num) {
        NSLog(@"加载了%@个字体",num);
    }).catch(^(NSError* e) {
        NSLog(@"%@",e);
    });
}




@end
