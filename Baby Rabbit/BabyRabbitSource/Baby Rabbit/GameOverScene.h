//
//  GameOverScene.h
//  MissileComp
//
//  Created by Taha Doğan Güneş on 2/1/12.
//  Copyright (c) 2012 TDG All rights reserved.
//
#import "cocos2d.h"

#import <Twitter/Twitter.h>
@interface GameOverLayer : CCLayerColor <UIActionSheetDelegate> {
    CCLabelTTF *_label;
    CCParticleSystem *_emitter;
    CCParticleSystem *_emitter1;
      CCSpriteBatchNode *_spriteSheet;
    CCLabelTTF *alabel;
    UIImage *_screenShot;
    BOOL _highScore;
     UIViewController * tempVC;
    NSString *_howmanydogs;
}

- (void)gameOverDone:(id)sender;
- (void) goToMenu:(id)sender;
- (void) tweetItWithScreenshot;
@property (nonatomic,retain) UIViewController *tempVC;
@property (nonatomic, retain) UIImage *screenShot;
@property (nonatomic) BOOL highScore;
@property (nonatomic, retain) CCLabelTTF *label;
@property (nonatomic, retain)  CCParticleSystem *emitter;
@property (nonatomic, retain)  CCParticleSystem *emitter1;
@property (nonatomic, retain) CCSpriteBatchNode *spriteSheet;
@property (nonatomic, retain) NSString *howmanydogs;
@end

@interface GameOverScene : CCScene {
    GameOverLayer *_layer;
}
@property (nonatomic, retain) GameOverLayer *layer;
@end