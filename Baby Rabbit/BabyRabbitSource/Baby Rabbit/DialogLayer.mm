//
//  DialogLayer.m
//  Baby Rabbit
//
//  Created by Taha Doğan Güneş on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DialogLayer.h"
CCLabelTTF *pauser;
CCLabelTTF *musical ;

CCLabelTTF *leader;
CCLabelTTF *coner;
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
@implementation DialogLayer
@synthesize parentLayer = _parentLayer;
-(id) initWithLayer:(HelloWorldLayer *)parentlayer
{
    if( (self=[super initWithColor:ccc4(124,125,195,100)] )) {
    
        // [self authenticateLocalPlayer];
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game.plist"];
        // frame = [[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"background.png"];
        // CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"game.pvr"];
        //[self addChild:spriteSheet];
        self.parentLayer = parentlayer;
        pauser = [CCLabelTTF labelWithString:@"Return To Menu" fontName:@"Chalkduster" fontSize:40];
        
        musical = [CCLabelTTF labelWithString:@"Music - ON" fontName:@"Chalkduster" fontSize:40];
        leader = [CCLabelTTF labelWithString:@"Sounds - ON" fontName:@"Chalkduster" fontSize:40];
        coner = [CCLabelTTF labelWithString:@"Continue" fontName:@"Chalkduster" fontSize:40];
        
        
        pauser.color = ccBLACK;
        musical.color = ccBLACK;

        leader.color = ccBLACK;
        coner.color = ccBLACK;
        
        
        CCMenuItemLabel *goButton = [CCMenuItemLabel itemWithLabel:pauser target:self selector:@selector(toTheMenu)];

        //music
        CCMenuItemLabel *objButton = [CCMenuItemLabel itemWithLabel:musical target:self selector:@selector(musicOnOff)];
        //sound
        CCMenuItemLabel *leadButton = [CCMenuItemLabel itemWithLabel:leader target:self selector:@selector(soundOnOff)];
        //reset
        CCMenuItemLabel *aboutButton = [CCMenuItemLabel itemWithLabel:coner target:self selector:@selector(continueGame)];
        
        CCMenu *menu = [CCMenu menuWithItems:aboutButton  ,leadButton, objButton,  goButton, nil];
        [menu setPosition:ccp(235,160)];
        [menu alignItemsVertically];
        [self addChild: menu];
        
     

        
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Music"]) {
            case 1:
                [musical setString:@"Music - ON"];
                 
                break;
                
            case 0:
                [musical setString:@"Music - OFF"];
              
                break;
        }
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]) {
            case 1:
                [leader setString:@"Sounds - ON"];
                break;
                
            case 0:
                [leader setString:@"Sounds - OFF"];
                break;
        }
    
    }
        return self;
}

- (void) soundOnOff{

    if ([[leader string] isEqualToString:@"Sounds - ON" ]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"Sound"];
        [leader setString:@"Sounds - OFF"];
        
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Sound"];
        [leader setString:@"Sounds - ON"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
}
- (void) musicOnOff{

    if ([[musical string] isEqualToString:@"Music - ON" ]) {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",0] forKey:@"Music"];
        [musical setString:@"Music - OFF"];
          [[ SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"Music"];
        [musical setString:@"Music - ON"];
         [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"secondtrack.mp3" loop:YES];
    }
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) toTheMenu{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
     [self removeFromParentAndCleanup:YES];
    [[ SimpleAudioEngine sharedEngine] pauseBackgroundMusic];
    [_parentLayer returnToMain];
}
- (void) continueGame{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }
    NSLog(@"Dialog");
    [self removeFromParentAndCleanup:YES];
    [_parentLayer runAllOfThem];
}

-(void) dealloc
{
  
    [super dealloc];
}
    
@end
