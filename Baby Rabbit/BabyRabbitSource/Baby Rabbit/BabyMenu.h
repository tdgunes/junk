//
//  BabyMenu.h
//  MissileComp
//
//  Created by Taha Doğan Güneş on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"
#import <GameKit/Gamekit.h>
#import "RootViewController.h"
#import <UIKit/UIKit.h>
@interface BabyMenu : CCLayerColor<GKLeaderboardViewControllerDelegate,  GKAchievementViewControllerDelegate >
{
    
    UIViewController *tempVC;
    
    
    
}
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController;
@property (nonatomic,retain) UIViewController *tempVC;

- (void) startTheGame: (id) sender;
- (void) showLeaderboard:(id)sender;
- (void) showAchievements:(id)sender;
- (void) resetEverything: (id) sender;
- (void) reportScore: (int64_t) score forCategory: (NSString*) category;
- (void) goOptions;
- (NSString *)md5HexDigest:(NSString*)input;
// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
@end
