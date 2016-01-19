//
//  Tutorial.m
//  Baby Rabbit
//
//  Created by Taha Doğan Güneş on 2/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Tutorial.h"
#import "SimpleAudioEngine.h"
#import "HelloWorldLayer.h"
CCSprite *pictureShower;
int indexer = 1;
@implementation Tutorial
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Tutorial *layer = [Tutorial node];
	
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
    indexer = 1;
    if( (self=[super initWithColor:ccc4(124,125,195,255)] )) {
        self.isTouchEnabled = YES;
                CGSize winSize = [[CCDirector sharedDirector] winSize];
        pictureShower = [CCSprite spriteWithFile:@"1.png"];
        pictureShower.position = ccp(winSize.width/2,winSize.height/2);
        [self addChild:pictureShower];
        // [self authenticateLocalPlayer];
        //[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game.plist"];
        // frame = [[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"background.png"];
        // CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"game.pvr"];
        //[self addChild:spriteSheet];
        
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Music"]==1) {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"secondtrack.mp3"];
            
        }
        
        
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
    indexer +=1;
    if (indexer==6){
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"tutorial"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        CCScene *game = [HelloWorldLayer scene];
        
        [[CCDirector sharedDirector] replaceScene:
         [CCTransitionSlideInR transitionWithDuration:0.8f scene:game]];
    }
    else {
        [pictureShower setTexture:[[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"%i.png", indexer]]];
    }
}

@end
