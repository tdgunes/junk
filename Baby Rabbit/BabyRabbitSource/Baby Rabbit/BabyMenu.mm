//
//  BabyMenu.m
//  MissileComp
//
//  Created by Taha Doğan Güneş on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BabyMenu.h"
#import "HelloWorldLayer.h"
#import "AppDelegate.h"
#import "OptionMenu.h"
#import "SimpleAudioEngine.h"
#import "Tutorial.h"
#import <CommonCrypto/CommonDigest.h>
BOOL GCOK;
BOOL GOOD;
@implementation BabyMenu

@synthesize tempVC;


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BabyMenu *layer = [BabyMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}
- (void) authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
        if (localPlayer.isAuthenticated)
        {
            // Perform additional tasks for the authenticated player.
            GOOD = YES;
        }
        else {
            GOOD = NO;
        }
    }];
}

- (void) showAchievements:(id)sender{
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    if (GCOK && GOOD) {
           
           
           tempVC = [[RootViewController alloc] init];
           
           GKAchievementViewController *leaderboardController = [[[GKAchievementViewController alloc] init] autorelease];
           if (leaderboardController != nil)
           {
               leaderboardController.achievementDelegate = self;
               [[[[CCDirector sharedDirector] openGLView] window] addSubview:tempVC.view];
               [tempVC presentModalViewController:leaderboardController animated: YES];
           }
       }
    

}
- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];	
    
	[tempVC dismissModalViewControllerAnimated:YES];
	[tempVC.view removeFromSuperview];
	//[[CCDirector sharedDirector] replaceScene:[MainMenuScene node]];
    
	[app.window bringSubviewToFront:[app.viewController view]];
}

- (void) showLeaderboard:(id)sender
{
    /*
    GKLeaderboardViewController *leaderboardController = [[[GKLeaderboardViewController alloc] init] autorelease];
    tempVC = [[RootViewController alloc] init];
    if (leaderboardController != nil)
    {
        leaderboardController.leaderboardDelegate = self;

        [[[CCDirector sharedDirector] openGLView] addSubview:tempVC.view];
        [tempVC presentModalViewController:leaderboardController animated: YES];

    }*/
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    if (GCOK && GOOD) {
        
        tempVC = [[RootViewController alloc] init];
        
        GKLeaderboardViewController *leaderboardController = [[[GKLeaderboardViewController alloc] init] autorelease];
        if (leaderboardController != nil)
        {
            leaderboardController.leaderboardDelegate = self;
            [[[[CCDirector sharedDirector] openGLView] window] addSubview:tempVC.view];
            [tempVC presentModalViewController:leaderboardController animated: YES];
        }
    }

}
- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
    
   // [tempVC dismissModalViewControllerAnimated:YES];
   // [tempVC.view removeFromSuperview];
    
 
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];	
    
	[tempVC dismissModalViewControllerAnimated:YES];
	[tempVC.view removeFromSuperview];
	//[[CCDirector sharedDirector] replaceScene:[MainMenuScene node]];
    
	[app.window bringSubviewToFront:[app.viewController view]];
}
- (void) goOptions{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    CCScene *game = [OptionMenu scene];
    
    
    [[CCDirector sharedDirector] replaceScene:game];
    
    
}
-(id) init
{
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    // SeekersWayPoints = [[NSMutableArray alloc] init];
    
	   if( (self=[super initWithColor:ccc4(124,125,195,255)] )) {
        self.isTouchEnabled = YES;
 
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game.plist"];
        // frame = [[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"background.png"];
       // CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"game.pvr"];
        //[self addChild:spriteSheet];
        CCLabelTTF *start = [CCLabelTTF labelWithString:@"Play!" fontName:@"Chalkduster" fontSize:60];
        CCLabelTTF *obj = [CCLabelTTF labelWithString:@"Achievements" fontName:@"Chalkduster" fontSize:60];
        CCLabelTTF *lead = [CCLabelTTF labelWithString:@"Leaderboards" fontName:@"Chalkduster" fontSize:60];
        CCLabelTTF *about = [CCLabelTTF labelWithString:@"Options" fontName:@"Chalkduster" fontSize:60];
           
           start.color = ccBLACK;
           obj.color = ccBLACK;
           lead.color = ccBLACK;
           about.color = ccBLACK;
           
        CCMenuItemLabel *startButton = [CCMenuItemLabel itemWithLabel:start target:self selector:@selector(startTheGame:)];
        CCMenuItemLabel *objButton = [CCMenuItemLabel itemWithLabel:obj target:self selector:@selector(showAchievements:)];
        CCMenuItemLabel *leadButton = [CCMenuItemLabel itemWithLabel:lead target:self selector:@selector(showLeaderboard:)];
        CCMenuItemLabel *aboutButton = [CCMenuItemLabel itemWithLabel:about target:self selector:@selector(goOptions)];
           
        CCMenu *menu = [CCMenu menuWithItems: startButton,leadButton, objButton, aboutButton, nil];
        [menu setPosition:ccp(240,160)];
        [menu alignItemsVertically];
        [self addChild: menu];
           
           
        if( [[NSUserDefaults standardUserDefaults] objectForKey:@"Sound"] ==nil){
               [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Sound"];
               [[NSUserDefaults standardUserDefaults] synchronize];
        }

        if( [[NSUserDefaults standardUserDefaults] objectForKey:@"Music"] ==nil){
               [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Music"];
               [[NSUserDefaults standardUserDefaults] synchronize];
            
        }

        if( [[NSUserDefaults standardUserDefaults] objectForKey:@"GC"] ==nil){
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"GC"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"NotSent"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"12"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"13"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"14"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"15"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"16"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"17"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"18"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"tutorial"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Sound"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"GC"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Music"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"score"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"Control"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
           NSLog(@"Configuration");
           NSLog(@"-------------------------");
           NSLog(@"Game Center: %i",[[NSUserDefaults standardUserDefaults] integerForKey:@"GC"]);
           NSLog(@"Music: %i",[[NSUserDefaults standardUserDefaults] integerForKey:@"Music"]);
           NSLog(@"15: %i",[[NSUserDefaults standardUserDefaults] integerForKey:@"15"]);
            NSLog(@"-------------------------");
           
           if ([[NSUserDefaults standardUserDefaults] integerForKey:@"GC"]==0) {
               GCOK = NO;
           }
           else {
               GCOK = YES;
            [self authenticateLocalPlayer];
           }
           
         //[[NSUserDefaults standardUserDefaults] setObject:scoretext forKey:@"NotSent"];
           if( [[[NSUserDefaults standardUserDefaults] objectForKey:@"NotSent"] isEqualToString:@"0"]){
               NSLog(@"no score found");
           }
           else{
               NSLog(@"notsent score found");
               NSString *ascore = [[NSUserDefaults standardUserDefaults] objectForKey:@"NotSent"] ;
               NSArray *sitems = [ascore componentsSeparatedByString:@"-"];
               NSLog(@"ascore %@ md5:%@", [sitems objectAtIndex:0], [sitems objectAtIndex:1]);
        
               NSString *great = [self md5HexDigest:[NSString stringWithFormat:@"%@tdg",[sitems objectAtIndex:0]]];
               NSLog(@"great: %@", great);
               if ([[sitems objectAtIndex:1]isEqualToString:great]) {
                   NSLog(@"Score is not harmed sending!");
                   [self reportScore:[[sitems objectAtIndex:0] intValue] forCategory:@"983720573960182"];
                   [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"NotSent"];
               }
               else {
                   NSLog(@"score cannot be resend!");
               }
               
               
               
           }
    }
    return self;
}
- (void) resetEverything: (id) sender{
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"score"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    

        // Clear all locally saved achievement objects.
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if (error == NULL) {
                NSLog(@"reset Sent");
            } else {
                NSLog(@"reset Failed");
            }
        });
    }];
}
- (void) reportScore: (int64_t) score forCategory: (NSString*) category
{
    NSLog(@"reporting");
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
    scoreReporter.value = score;
    
    
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if (error == NULL) {
                NSLog(@"Score Sent");
            } else {
                NSString *nice = [self md5HexDigest:[NSString stringWithFormat:@"%itdg",score]];
                NSLog(@"scorer: %@",nice);
                NSString *scoretext = [NSString stringWithFormat:@"%i-",score];
                scoretext = [scoretext stringByAppendingString:nice];
                NSLog(@"scorer: %@",scoretext);
                [[NSUserDefaults standardUserDefaults] setObject:scoretext forKey:@"NotSent"];
                NSLog(@"Score Failed");            }
        });
    }];
    
    
    
    
}
- (NSString *)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
- (void) startTheGame: (id) sender {
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"tutorial"]==0) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
        CCScene *game = [Tutorial scene];
        
        [[CCDirector sharedDirector] replaceScene:game];
    }
    else {
        CCScene *game = [HelloWorldLayer scene];
        
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionSlideInR transitionWithDuration:0.8f scene:game]];
    }

}
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

- (void) onEnter {
    
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
	[super onEnter];
}

- (void) onExit {
    
    [[CCTouchDispatcher sharedDispatcher] removeDelegate: self];
	[super onExit];
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    
}

@end
