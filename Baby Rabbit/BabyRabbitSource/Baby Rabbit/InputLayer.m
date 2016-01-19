//
//  InputLayer.m
//  ScrollingWithJoy
//
//  Created by Steffen Itterheim on 04.08.10.
//
//  Updated by Andreas Loew on 20.06.11:
//  * retina display
//  * framerate independency
//  * using TexturePacker http://www.texturepacker.com
//
//  Copyright Steffen Itterheim and Andreas Loew 2010-2011. 
//  All rights reserved.
//

#import "InputLayer.h"
#import "HelloWorldLayer.h"

int incvelocity =0;
@interface InputLayer (PrivateMethods)
-(void) addFireButton;
-(void) addJoystick;
@end


@implementation InputLayer

-(id) init
{
	if ((self = [super init]))
	{
        incvelocity =0;
		[self addFireButton];
		[self addJoystick];
		
		[self scheduleUpdate];
	}
	
	return self;
}

-(void) dealloc
{
	[super dealloc];
}

-(void) addFireButton
{
	float buttonRadius = 50;
	CGSize screenSize = [[CCDirector sharedDirector] winSize];

	fireButton = [SneakyButton button];
	fireButton.isHoldable = YES;
	
	SneakyButtonSkinnedBase* skinFireButton = [SneakyButtonSkinnedBase skinnedButton];
	skinFireButton.position = CGPointMake(screenSize.width - buttonRadius * 1.5f, buttonRadius * 1.5f);
	skinFireButton.defaultSprite = [CCSprite spriteWithSpriteFrameName:@"deadcarrotplant.png"];


	skinFireButton.pressSprite = [CCSprite spriteWithSpriteFrameName:@"carrotplant.png"];
	skinFireButton.button = fireButton;
	[self addChild:skinFireButton];
}

-(void) addJoystick
{
	float stickRadius = 50;

	joystick = [SneakyJoystick joystickWithRect:CGRectMake(0, 0, stickRadius, stickRadius)];
	joystick.autoCenter = YES;
	
	// Now with fewer directions
	joystick.isDPad = YES;
	joystick.numberOfDirections = 32;
	
	SneakyJoystickSkinnedBase* skinStick = [SneakyJoystickSkinnedBase skinnedJoystick];
	skinStick.position = CGPointMake(stickRadius * 1.5f, stickRadius * 1.5f);
	//skinStick.backgroundSprite = [CCSprite spriteWithSpriteFrameName:@"carrotplant.png"];
	skinStick.backgroundSprite.color = ccYELLOW;
	skinStick.thumbSprite = [CCSprite spriteWithSpriteFrameName:@"powerplant.png"];
	skinStick.joystick = joystick;
	[self addChild:skinStick];
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
            return ccp(pos.x, 214);
        }
        if (pos.y<80.0 && pos.x>74) {
            return ccp(pos.x, 80.0);
        }
        
    }
    
    
    if (pos.x<0) {
        return ccp(30, pos.y);
    }
    if (pos.x>480.0) {
        return ccp(470.0, pos.y);
    } 
    return pos;
}




-(void) update:(ccTime)delta //best collision detection system :D for map
{
	totalTime += delta;
    if (incvelocity > 0 ) incvelocity -= incvelocity/100;
	// Continuous fire
	if (fireButton.active && totalTime > nextShotTime)
	{
		nextShotTime = totalTime + 0.5f;
		NSLog(@"Nice");
        incvelocity += 160;
		//HelloWorldLayer* game = [HelloWorldLayer sharedGameScene];
        if (incvelocity>2000) incvelocity = 2000;
		//[game shootBulletFromShip:[game defaultShip]];
	}
	
	// Allow faster shooting by quickly tapping the fire button.
	if (fireButton.active == NO)
	{
		
	}
	
	// Moving the ship with the thumbstick.
	HelloWorldLayer* game = [HelloWorldLayer sharedGameScene];
	CCSprite* ship = game.rabbit;
	
	CGPoint velocity = ccpMult(joystick.velocity, 6500 * delta+(incvelocity/20.0));
	if (velocity.x != 0 && velocity.y != 0 && [game collisionOfSprite:ship] == NO)
	{
   
  
        
       [ship stopAction:game.moveAction];
      //  [ship stopAction:game.walkAction];
        CGPoint touchLocation = CGPointMake(ship.position.x + velocity.x * delta, ship.position.y + velocity.y * delta );
        CGPoint moveDifference = ccpSub(touchLocation, ship.position);
         float rabbitVelocity = (300.0+incvelocity/10.0)/3.0;
        float distanceToMove = ccpLength(moveDifference);
        float moveDuration = distanceToMove / rabbitVelocity;
        CCAction *rabbitWalk = game.walkAction;
        
        if (moveDifference.x < 0) {
            ship.flipX = NO;
        } else {
            ship.flipX = YES;
        }  
        if (!game.moving) {
            [ship runAction:rabbitWalk];
        }
        
        game.moving = TRUE;
        ship.position =touchLocation;
        
        
        game.moveAction = [CCSequence actions:                          
                           [CCMoveTo actionWithDuration:moveDuration position:touchLocation],
                           //[CCCallFunc actionWithTarget:game selector:@selector(rabbitMoveEnded)],
                           nil];
        
        //ship.position = [self canGO:touchLocation firstPos:ship.position];
     //   NSLog(@"rabbit vel: x: %f y: %f",ship.position.x,ship.position.y);
        [ship runAction:game.moveAction];
	}
    
    else {
        game.moving = NO;
        [game rabbitMoveEnded];
    }
    
    
    
       
}

@end
