//
//  Dog.h
//  MissileComp
//
//  Created by Taha Doğan Güneş on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface Dog : CCSprite{
    
    BOOL _dogmoving;
    CCAction *_dogWalkAction;
    CCAction *_dogMoveAction;
    int dogFollow;
    int waitInterval;
    CCSprite *_rabbit;
    float velocity; 
}
@property (nonatomic) BOOL _dogmoving;
@property (nonatomic) int waitInterval;
@property (nonatomic) float velocity;
@property (nonatomic, retain) CCSprite *rabbit;
@property (nonatomic, retain) CCAction *dogMoveAction;
@property (nonatomic, retain) CCAction *dogWalkAction;
- (void) dogWalkAnimation;
- (void) dogMoveEnded;
- (void) dogMove;

- (BOOL) dogRadiusEntered:(float)radius setSprite:(CCSprite *)sprite;

- (BOOL) randomWaitOK;

- (CGPoint) canGO:(CGPoint)pos firstPos:(CGPoint)firstpos;

- (CGPoint) WayPointMakerbyRadius:(float)radius withSprite:(CGPoint)pos;
- (BOOL) aPosition:(CGPoint)apos enteredToPosition:(CGPoint)epos withRadius:(float)radius;
@end
