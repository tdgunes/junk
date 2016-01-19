//
//  HelloWorldLayer.h
//  MissileComp
//
//  Created by Taha Doğan Güneş on 11/30/11.
//  Copyright TDG 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Dog.h"
#import <GameKit/Gamekit.h>
//#import "chipmunk.h"
// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
   // CCSprite *_dog;
    CCSprite *_rabbit;
    CCSprite *_babyrabbit;
    CCSprite *_progressbar;
    
    CCAction *_walkAction;
    CCAction *_moveAction;

   
    BOOL _moving;
    
    NSMutableArray *_carrots;
    NSMutableArray *_phycarrots;
    NSMutableArray *_dogs;
    NSMutableArray *_eatables;
    NSMutableArray *_heartlist;
    NSMutableArray *_achrequests;
    BOOL _dogmoving;
    
    CCSpriteBatchNode *_spriteSheet;
   // CCAction *_dogWalkAction;
   //CCAction *_dogMoveAction;

    //NSMutableArray *SeekersWayPoints;
    
    CCLabelTTF *_scoreShow;
    CCLabelTTF *_scoreShadow;
    
    
    CCSprite *_achievementBar;

    CCAction *_achievementAction;
    UIImage *screenimage;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

//-(void) addNewSprite:(float)x y:(float)y;
@property (nonatomic, retain)  NSMutableArray *heartlist;
@property (nonatomic, retain) NSMutableArray *achrequests;
@property (nonatomic, retain) NSMutableArray *eatables;
@property (nonatomic, retain) NSMutableArray *dogs;
@property (nonatomic, retain) NSMutableArray *carrots;
@property (nonatomic, retain) NSMutableArray *phycarrots;
@property (nonatomic, retain) CCSpriteBatchNode *spriteSheet;
@property (nonatomic, retain) CCSprite *rabbit;
@property (nonatomic, retain) CCSprite *progressbar;
@property (nonatomic, retain) CCSprite *achievementBar;
@property (nonatomic) BOOL moving;
@property (nonatomic, retain) CCSprite *babyrabbit;
//@property (nonatomic, retain) CCSprite *dog;
@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCAction *moveAction;

@property (nonatomic, retain) CCSprite *scoreShow;
@property (nonatomic, retain) CCSprite *scoreShadow;
//@property (nonatomic, retain) CCAction *dogMoveAction;
//@property (nonatomic, retain) CCAction *dogWalkAction;
@property (nonatomic, retain) CCAction *achievementAction;
@property (copy,nonatomic)  UIImage *screenimage;
- (void) collisionDetect;
- (BOOL) collisionOfSprite:(CCSprite *)sprite;
- (CGPoint) positionFromSpriteThatWillBeFixedForTheCollisionDetection:(CCSprite *)sprite;
- (NSString *)md5HexDigest:(NSString*)input ;
- (void) addAHeartCarrot;
- (void) returnToMain;
- (CGRect)makeRect:(CCSprite *)mySprite;
- (void) runAllOfThem;
- (void) showAchievementWithString:(NSString *)achtext anew:(BOOL)newone;
-(void) carrotGenerate:(int)number;
-(void)rabbitMoveEnded;
-(void) checkRabbitTouchedCarrot;
-(NSMutableArray *) generatePositions;
- (NSMutableArray *) generateRandoms:(int)number;
- (void) achShowTotalyFinished;
- (void) addADog;
//- (void) dogMove;
//- (void) dogMoveEnded;
//- (BOOL) dogRadiusEntered:(float)radius setSprite:(CCSprite *)sprite;
- (CGPoint) WayPointMakerbyRadius:(float)radius withSprite:(CCSprite *)sprite;
- (BOOL) aPosition:(CGPoint)apos enteredToPosition:(CGPoint)epos withRadius:(float)radius;
- (BOOL) randomWaitOK;
- (CGPoint) canGO:(CGPoint)pos firstPos:(CGPoint)firstpos;
- (BOOL) array:(NSMutableArray *)array hasThisString:(NSString *)mystring;
- (CGPoint) IamTheDogAndICatchedYourRabbit;
- (void) reportScore: (int64_t) score forCategory: (NSString*) category;
- (void) returnToMenu:(id) sender;
- (BOOL) chanceWithNumber:(int)number;
- (void) generateCarrotsWithTime:(id)sender;
- (void) progressTheHunger:(id)sender;
- (void) progressOfDogAndLevel:(id)sender;
- (void) progressOfBabysEating:(id)sender;
- (void) achievementShowFinished;
- (void) progressOfEatableCarrots:(id)sender;
/*
- (void) checkCocosGuy ;
- (void) moveCocosGuy;
- (void) rightLeftControl;
*/
- (void) increaseHeart;
- (void) decreaseHeart;


+(HelloWorldLayer*) sharedGameScene;
@end
