//
//  GameOverScene.m
//  MissileComp
//
//  Created by Taha Doğan Güneş on 2/1/12.
//  Copyright (c) 2012 TDG All rights reserved.
//
#import "GameOverScene.h"
#import "HelloWorldLayer.h"
#import "BabyMenu.h"
#import "SimpleAudioEngine.h"
#import "RootViewController.h"

#import "AppDelegate.h"


@implementation GameOverScene
@synthesize layer = _layer;
- (id)init {
    
    if ((self = [super init])) {
        self.layer = [GameOverLayer node];
        [self addChild:_layer];
    }
    return self;
}

- (void)dealloc {
    [_layer release];
    _layer = nil;
    [super dealloc];
}

@end

@implementation GameOverLayer
@synthesize label = _label;
@synthesize emitter = _emitter;
@synthesize emitter1 = _emitter1;
@synthesize highScore = _highScore;
@synthesize spriteSheet = _spriteSheet;
@synthesize screenShot = _screenShot;
@synthesize howmanydogs = _howmanydogs;
@synthesize tempVC;
-(id) init
{
    if( (self=[super initWithColor:ccc4(124,255,255,255)] )) {
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game.plist"];
        // frame = [[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"background.png"];
        _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"game.pvr"];
        [self addChild:_spriteSheet];

        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self.label = [CCLabelTTF labelWithString:@"" fontName:@"AmericanTypewriter-Bold" fontSize:32];
        _label.color = ccc3(0,0,0);
        _label.position = ccp(winSize.width/2, (winSize.height/2)-50);
        [self addChild:_label];

        self.emitter = [[CCParticleFireworks alloc] init];
        
        _emitter.position = ccp(winSize.width,winSize.height/2-40);
        [_emitter setScaleX:0.9];
        [_emitter setScaleY:0.7];

          _emitter.rotation = 320;
        
       
        
        self.emitter1 = [[CCParticleFireworks alloc] init];
        
        _emitter1.position = ccp(0,winSize.height/2-40);
        [_emitter1 setScaleX:0.9];
        [_emitter1 setScaleY:0.7];
        _emitter1.rotation = 40;
        [self addChild:_emitter];
        [self addChild:_emitter1];
        
        
         alabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"High Score: %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"score"]] fontName:@"AmericanTypewriter-Bold"  fontSize:30];
        
        CCLabelTTF *start = [CCLabelTTF labelWithString:@"Play!" fontName:@"AmericanTypewriter-Bold" fontSize:30];
        CCLabelTTF *nenu = [CCLabelTTF labelWithString:@"Menu" fontName:@"AmericanTypewriter-Bold" fontSize:30];
        CCLabelTTF *tweet = [CCLabelTTF labelWithString:@"Share" fontName:@"AmericanTypewriter-Bold" fontSize:30];
        start.color = ccBLACK;
        nenu.color = ccBLACK;
        tweet.color = ccBLACK;
        CCMenuItemLabel *startButton = [CCMenuItemLabel itemWithLabel:start target:self selector:@selector(gameOverDone:)];
        CCMenuItemLabel *nenuButton = [CCMenuItemLabel itemWithLabel:nenu target:self selector:@selector(goToMenu:)];
        CCMenuItemLabel *tweetButton = [CCMenuItemLabel itemWithLabel:tweet target:self selector:@selector(tweetItWithScreenshot)];
        
        CCMenu *menu = [CCMenu menuWithItems: startButton,nenuButton,tweetButton, nil];
        [menu setPosition:ccp(240,160)];
        [menu alignItemsHorizontally];
        [self addChild: menu];

        alabel.position = ccp(240,50);
        alabel.color = ccBLACK;
        [self addChild:alabel];
        CCSprite *arabbit = [CCSprite spriteWithSpriteFrameName:@"rabbit-1.png"];
        arabbit.position = ccp(winSize.width/2-40,230);
     
        CCSprite *asrabbit = [CCSprite spriteWithSpriteFrameName:@"rabbit-1.png"];
        asrabbit.position = ccp(arabbit.position.x+2,arabbit.position.y-2);
        asrabbit.color = ccc3(255,255,255);
        asrabbit.opacity = 150;
       
        [_spriteSheet addChild:asrabbit];
        [_spriteSheet addChild:arabbit];
        
        
        
        
        CCSprite *brabbit = [CCSprite spriteWithSpriteFrameName:@"rabbit-1.png"];
        brabbit.position = ccp(winSize.width/2+30,220);
        brabbit.scale = 0.75;
        
        CCSprite *abrabbit = [CCSprite spriteWithSpriteFrameName:@"rabbit-1.png"];
        abrabbit.position = ccp(brabbit.position.x+2,brabbit.position.y-2);
        abrabbit.scale = 0.75;
        abrabbit.color = ccc3(255,255,255);
        abrabbit.opacity = 150;
        [_spriteSheet addChild:abrabbit];

        [_spriteSheet addChild:brabbit];
        [[ SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"gamewon.mp3"];
        }

    }	
    return self;
}



-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	
    
    if (buttonIndex == 0) {
        TWTweetComposeViewController *twitter = [[TWTweetComposeViewController alloc] init];
        
        // Optional: set an image, url and initial text
        [twitter addImage:self.screenShot];
        [twitter addURL:[NSURL URLWithString:[NSString stringWithString:@"http://tdgunes.org/babyrabbit"]]];
        [twitter setInitialText:[NSString stringWithFormat:@"My %@in @BabyRabbitApp with %@ dog(s)!", _label.string, _howmanydogs ]];
        [tempVC presentModalViewController:twitter animated:YES];
        
        twitter.completionHandler = ^(TWTweetComposeViewControllerResult result) 
        {
            //  NSString *title = @"Tweet Status";
            NSString *msg; 
            
            if (result == TWTweetComposeViewControllerResultCancelled)
                msg = @"Tweet compostion was canceled.";
            else if (result == TWTweetComposeViewControllerResultDone)
                msg = @"Tweet composition completed.";
            
            // Show alert to see how things went...
            //  UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
            // [alertView show];
            
            // Dismiss the controller
     
            //[[CCDirector sharedDirector] replaceScene:[MainMenuScene node]];
            
            AppDelegate *app = [[UIApplication sharedApplication] delegate];	
            
            [tempVC dismissModalViewControllerAnimated:YES];
            [tempVC.view removeFromSuperview];
            [app.window bringSubviewToFront:[app.viewController view]];

            
            
        };
    }
           
    else if (buttonIndex == 1) {
       
        UIImageWriteToSavedPhotosAlbum (self.screenShot, nil, nil, nil);
        AppDelegate *app = [[UIApplication sharedApplication] delegate];	
        
        [tempVC dismissModalViewControllerAnimated:YES];
        [tempVC.view removeFromSuperview];
        //[[CCDirector sharedDirector] replaceScene:[MainMenuScene node]];
        
        [app.window bringSubviewToFront:[app.viewController view]];

        } 
    else if (buttonIndex == 2) {//cancel
        AppDelegate *app = [[UIApplication sharedApplication] delegate];	
        
        [tempVC dismissModalViewControllerAnimated:YES];
        [tempVC.view removeFromSuperview];
        //[[CCDirector sharedDirector] replaceScene:[MainMenuScene node]];
        
        [app.window bringSubviewToFront:[app.viewController view]];
        }
    
    
    
    
}






- (void) tweetItWithScreenshot{
    // Create the view controller
   // UIImageWriteToSavedPhotosAlbum(screenShot, self, @selector(goToMenu:), nil);
    
    
    
    
    tempVC = [[RootViewController alloc] init];
        // Show the controller
    [[[[CCDirector sharedDirector] openGLView] window] addSubview:tempVC.view];

    UIActionSheet *popupQuery = [[UIActionSheet alloc] initWithTitle:@"Share Your Score!" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Tweet It!", @"Save to Photo Library",nil];
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    AppDelegate *app = [[UIApplication sharedApplication] delegate];	
    

    //[[CCDirector sharedDirector] replaceScene:[MainMenuScene node]];

    [popupQuery showInView:[app.viewController view]];
    [popupQuery release];

    // Called when the tweet dialog has been closed
    

}                                                                          
- (void) onEnter {
    
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    if (_highScore) {

        
    }
	[super onEnter];
}

- (void) onExit {
    
    [[CCTouchDispatcher sharedDispatcher] removeDelegate: self];
	[super onExit];
}
- (void) goToMenu:(id)sender {
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFade transitionWithDuration:0.5f scene:[BabyMenu scene]]];

}

- (void)gameOverDone:(id)sender {
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionFade transitionWithDuration:0.5f scene:[HelloWorldLayer scene]]];

    
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}
- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
   
}
- (void)dealloc {

    [super dealloc];
}

@end