//
//  Dog.m
//  MissileComp
//
//  Created by Taha Doğan Güneş on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Dog.h"
#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"
@implementation Dog
@synthesize rabbit = _rabbit;
@synthesize dogWalkAction = _dogWalkAction;
@synthesize dogMoveAction = _dogMoveAction;
@synthesize velocity;
@synthesize waitInterval;
@synthesize _dogmoving;

- (BOOL) aPosition:(CGPoint)apos enteredToPosition:(CGPoint)epos withRadius:(float)radius{
    CGPoint moveDifference = ccpSub(apos, epos);
    float distanceToMove = ccpLength(moveDifference);
    
    moveDifference = ccpSub(apos, epos);
    distanceToMove = ccpLength(moveDifference);
    if (distanceToMove<radius) {
        return YES;
    }
    else {
        return NO;
    }
    
}

- (CGPoint) WayPointMakerbyRadius:(float)radius withSprite:(CGPoint)pos
{
    CGPoint MCWayPoint;
    int x ;
    int y ;
    while (YES) {
        x = (arc4random() % 450) + 1;
        y = (arc4random() % 330) + 1;
        if ([self aPosition:ccp(x,y) enteredToPosition:pos withRadius:radius]) {
            break;
        }
        
    }
    
    MCWayPoint = ccp(x,y);
    return (MCWayPoint);
}

- (CGPoint) canGO:(CGPoint)pos firstPos:(CGPoint)firstpos{ //full integrated collision detection with geometry 
    //TDG proudly presents :)
    // NSLog(@"firstpos: fx:%f fy:%f lastpos: lx:%f ly:%f",firstpos.x, firstpos.y, pos.x,pos.y);
    if ((pos.y-80<-(99/75)*(pos.x-84)) && pos.x <= 73.5) {
        float gradient = (firstpos.y-pos.y)/(firstpos.x-pos.x);
        //y-80=-(99/75)(x-84) with pos.y as y pos.x as x
        //y-firstpos.y=gradient(x-firstpos.x) the other equation
        //y = -(99/75)(x-84)+80
        //y = gradient(x-firstpos.x)+firstpos.y
        //last going position will be calculated with these two lines. 
        //This equation calculates the position these two are crossed.
        //
        //y = -(1.32)*(x-84)+80
        //y =-1.32*x+190.88
        
        
        
        //y = gradient*(x-firstpos.x)+firstpos.y
        //y = gradient*x-firstpos.x*gradient + firstpos.y
        
        //x(-1.32-gradient)=-190.88-firstpos.x*gradient+firstpos.y
        float myx =-(-190.88-firstpos.x*gradient+firstpos.y)/(1.32+gradient);
        //NSLog(@"myx=%f",myx);
        if(myx>=73.5) {
            return ccp(myx,80.0);
        }
        else{
            return ccp(myx, (gradient*(myx-firstpos.x)+firstpos.y));
        }
    }
    
    if (pos.y<214.0 && pos.y>80.0 && (pos.y-80>-(99/75)*(pos.x-84))){
        return pos;
    }
    else {
        if (pos.y>214.0) {
            return ccp(pos.x, 220);
        }
        if (pos.y<80.0 && pos.x>74) {
            return ccp(pos.x, 80.0);
        }
        
    }
    
    
    if (pos.x<0) {
        return ccp(30, pos.y);
    }
    if (pos.x>480.0) {
        return ccp(480.0, pos.y);
    } 
    return pos;
}

- (BOOL) randomWaitOK{
    int chance = (arc4random() % 10) + 1;
    if (chance == 4) {
        return NO;
    }
    else {
        return YES;
    }
    
}
- (BOOL) dogRadiusEntered:(float)radius setSprite:(CCSprite *)sprite{
    CGPoint moveDifference = ccpSub(self.position, sprite.position);
    float distanceToMove = ccpLength(moveDifference);
    
    moveDifference = ccpSub(sprite.position, self.position);
    distanceToMove = ccpLength(moveDifference);
    if (distanceToMove<radius) {
        return YES;
    }
    else {
        return NO;
    }
    
}
- (void) dogMove{
    //NSLog(@"rabbitpos: x:%f y:%f",_rabbit.position.x, _rabbit.position.y);
    int chance = (arc4random() % 10) + 1;
    
    if (waitInterval == 0) {
        if ([self randomWaitOK]) {
            waitInterval = chance/10;
        }
        else {
            waitInterval = 0.0;
        }
    }
    
    
    CGPoint followLocation;
    
    if ([self dogRadiusEntered:50 setSprite:_rabbit]) {
       // waitInterval = 0;
        //changed for 0.6
        followLocation= [_rabbit position];
        dogFollow = 1;
    }
    else {
        if (dogFollow == 1) {
            waitInterval = 0.9;
            dogFollow =0;
        }
        followLocation = [self WayPointMakerbyRadius:130 withSprite:self.position];
        //followLocation = [self canGO:followLocation firstPos:self.position];
    }
    float dogVelocity = (300+velocity)/3.0;
    CGPoint moveDifference = ccpSub(followLocation, self.position);
    float distanceToMove = ccpLength(moveDifference);
    float moveDuration = distanceToMove / dogVelocity;
    
    if (moveDifference.x < 0) {
        self.flipX = NO;
    } else {
        self.flipX = YES;
    }    
    [self stopAction:_dogMoveAction]; 
    [self stopAction:_dogWalkAction];
    
    
    
    self.dogMoveAction = [CCSequence actions:   
                          [CCDelayTime actionWithDuration:waitInterval],
                          [CCCallFunc actionWithTarget:self selector:@selector(dogWalkAnimation)],
                          [CCMoveTo actionWithDuration:moveDuration position:followLocation],
                          [CCCallFunc actionWithTarget:self selector:@selector(dogMoveEnded)],
                          nil
                          ];
    
    
    [self runAction:_dogMoveAction];   
    _dogmoving = TRUE;
    waitInterval = 0;
}
- (void) dogWalkAnimation{
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        //[[SimpleAudioEngine sharedEngine] playEffect:@"dogmove.wav"];
    }
    [self runAction:_dogWalkAction];
}
- (void) dogMoveEnded {
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"dog-laugh.png"];
    [self setDisplayFrame:frame];
    [self stopAction:_dogWalkAction];
    _dogmoving = FALSE;
    [self dogMove];
    
    
}


@end
