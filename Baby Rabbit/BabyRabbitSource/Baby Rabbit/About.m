//
//  About.m
//  Baby Rabbit
//
//  Created by Taha Doğan Güneş on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "About.h"
#import "OptionMenu.h"
#import "SimpleAudioEngine.h"
@implementation About
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	About *layer = [About node];
	
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
          CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *pictureShower = [CCSprite spriteWithFile:@"about.png"];
        pictureShower.position = ccp(winSize.width/2,winSize.height/2);
        CCLabelTTF *version = [CCLabelTTF labelWithString:@"0.6" fontName:@"AmericanTypewriter-Bold" fontSize:14];
        version.color = ccBLACK;
        version.position = ccp(15,10);
       
        [self addChild:pictureShower];
         [self addChild:version];
        
    }
    return self;
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
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
    }

    
    CCScene *game = [OptionMenu scene];
    
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionSlideInR transitionWithDuration:0.8f scene:game]];
}

@end
