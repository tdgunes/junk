//
//  OptionMenu.m
//  Baby Rabbit
//
//  Created by Taha Doğan Güneş on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "SimpleAudioEngine.h"
#import "OptionMenu.h"
#import "BabyMenu.h"
#import "About.h"
CCLabelTTF *goback;
CCLabelTTF *start ;
CCLabelTTF *obj;
CCLabelTTF *lead;
CCLabelTTF *about;
CCLabelTTF *gamepad;
@implementation OptionMenu


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	OptionMenu *layer = [OptionMenu node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
    // SeekersWayPoints = [[NSMutableArray alloc] init];
    
    if( (self=[super initWithColor:ccc4(124,125,195,255)] )) {
        self.isTouchEnabled = YES;
       // [self authenticateLocalPlayer];
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game.plist"];
        // frame = [[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"background.png"];
        // CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"game.pvr"];
        //[self addChild:spriteSheet];
        goback = [CCLabelTTF labelWithString:@"To Menu" fontName:@"Chalkduster" fontSize:35];
        start = [CCLabelTTF labelWithString:@"Game Center - ON" fontName:@"Chalkduster" fontSize:35];
        obj = [CCLabelTTF labelWithString:@"Music - ON" fontName:@"Chalkduster" fontSize:35];
        lead = [CCLabelTTF labelWithString:@"Sounds - ON" fontName:@"Chalkduster" fontSize:35];
        gamepad =[CCLabelTTF labelWithString:@"Touches - ON" fontName:@"Chalkduster" fontSize:35];
        about = [CCLabelTTF labelWithString:@"Reset The Game" fontName:@"Chalkduster" fontSize:35];
       
        
        goback.color = ccBLACK;
        start.color = ccBLACK;
        obj.color = ccBLACK;
        lead.color = ccBLACK;
        about.color = ccBLACK;
        gamepad.color = ccBLACK;
      
        CCLabelTTF *aa = [CCLabelTTF labelWithString:@"About" fontName:@"Chalkduster" fontSize:20];
        aa.color = ccBLACK;
        CCMenuItemLabel *aaAbout = [CCMenuItemLabel itemWithLabel:aa target:self selector:@selector(goToAbout)];
        CCMenu *menu1 = [CCMenu menuWithItems:aaAbout,nil];
        [menu1 setPosition:ccp(440,20)];
        [self addChild:menu1];
        
        CCMenuItemLabel *goButton = [CCMenuItemLabel itemWithLabel:goback target:self selector:@selector(returnBack)];
        CCMenuItemLabel *startButton = [CCMenuItemLabel itemWithLabel:start target:self selector:@selector(gameCenterOnOff)];
        //music
        CCMenuItemLabel *objButton = [CCMenuItemLabel itemWithLabel:obj target:self selector:@selector(musicOnOff)];
        //sound
        CCMenuItemLabel *leadButton = [CCMenuItemLabel itemWithLabel:lead target:self selector:@selector(soundOnOff)];
        //gamepad
        CCMenuItemLabel *gcontrolButton = [CCMenuItemLabel itemWithLabel:gamepad target:self selector:@selector(gameControl)];
        //reset
        CCMenuItemLabel *aboutButton = [CCMenuItemLabel itemWithLabel:about target:self selector:@selector(resetAll)];
        
        CCMenu *menu = [CCMenu menuWithItems:  aboutButton,startButton,leadButton, objButton, gcontrolButton, goButton,nil];
        [menu setPosition:ccp(235,160)];
        [menu alignItemsVertically];
        [self addChild: menu];
        
        
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Control"]) {
            case 1: //Gamepad ON
                [gamepad setString:@"CarrotPad - ON"];
                break;
                
            case 0:// Touch ON
                [gamepad setString:@"Touches - ON"];
                break;
        }
        
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"GC"]) {
            case 1:
                 [start setString:@"Game Center - ON"];
                break;
                
            case 0:
                 [start setString:@"Game Center - OFF"];
                break;
        }
        
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Music"]) {
            case 1:
                   [obj setString:@"Music - ON"];
                break;
                
            case 0:
                   [obj setString:@"Music - OFF"];
                break;
        }
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]) {
            case 1:
                 [lead setString:@"Sounds - ON"];
                break;
                
            case 0:
                [lead setString:@"Sounds - OFF"];
                break;
        }
    }
    return self;
}
- (void) gameControl {
    if ([[gamepad string] isEqualToString:@"Touches - ON" ]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Control"];
        [gamepad setString:@"CarrotPad - ON"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"Control"];
        [gamepad setString:@"Touches - ON"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }

}
- (void) goToAbout {
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    CCScene *game = [About scene];
    
    
    [[CCDirector sharedDirector] replaceScene:game];
    
}
- (void) gameCenterOnOff{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    //
    /* if ([[NSUserDefaults standardUserDefaults] objectForKey:@"score"] !=nil) {
        NSString *mystring = [[NSUserDefaults standardUserDefaults] objectForKey:@"score"];
        if (score >=[mystring intValue]) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",score] forKey:@"score"];
            
            
        }
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",score] forKey:@"score"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }*/
    

    
    if ([[start string] isEqualToString:@"Game Center - ON" ]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"GC"];
        [start setString:@"Game Center - OFF"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",3] forKey:@"12"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",3] forKey:@"13"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",3] forKey:@"14"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",3] forKey:@"15"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",3] forKey:@"16"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",3] forKey:@"17"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",3] forKey:@"18"];
        
    }
    else {
         [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"GC"];
         [start setString:@"Game Center - ON"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"12"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"13"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"14"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"15"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"16"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"17"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"18"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void) soundOnOff{

    if ([[lead string] isEqualToString:@"Sounds - ON" ]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"Sound"];
        [lead setString:@"Sounds - OFF"];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Sound"];
        [lead setString:@"Sounds - ON"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
}
- (void) musicOnOff{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    if ([[obj string] isEqualToString:@"Music - ON" ]) {
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"Music"];
        [obj setString:@"Music - OFF"];
                  [[ SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    }
    else {
             [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Music"];
        [obj setString:@"Music - ON"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void) resetAll{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }

    if ([[about string] isEqualToString:@"Reset The Game"]) {
        [about setString:@"Are you sure ?"];
    }
    else {
        NSLog(@"achievement reset local done");
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"12"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"13"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"14"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"15"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"16"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"17"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"18"];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Sound"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"GC"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Music"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"score"];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"tutorial"];
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
        [self returnBack];
    }

}
- (void) returnBack{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    CCScene *game = [BabyMenu scene];
    
    
    [[CCDirector sharedDirector] replaceScene:game];
    
    
    
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
