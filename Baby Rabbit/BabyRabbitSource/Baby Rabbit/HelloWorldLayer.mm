//
//  HelloWorldLayer.m
//  MissileComp
//
//  Created by Taha Doğan Güneş on 11/30/11.
//  Copyright TDG 2011. All rights reserved.
//

 
*/
// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCTouchDispatcher.h"
#import "SimpleAudioEngine.h"
#import "GameOverScene.h"
#import "Carrot.h"
#import "Dog.h"
//#import "GKAchievementHandler.h"
#import "BabyMenu.h"
#import "DialogLayer.h"
#import "InputLayer.h"
#import "Heart.h"
#import <CommonCrypto/CommonDigest.h>

#define progressScale 3.0
#define dogScale 0.35
//CCSprite *cocosGuy;
CCSprite *background;
CCLabelTTF *label; 
CCLabelTTF *mlabel;
CCLabelTTF *alabel;
CGPoint MCGoal;

CCSpriteFrame *frame;
//int touches = 0;
//int frame = 0;
int third = 0;
int frames = 0;
int picture = 1;
int carrotsThatInIt = 0;
int score = 0;
int totalCarrots = 0;
int dogFollow = 0;//1 means yes
int stockCarrots= 0;
int hunger = 100;
int hungerscale = 4;
int level = 1;
float waitInterval;
int increaseVelocity = 0;
int generation = 0;
int carrotsThatWillbeEated = 0;
BOOL end = NO;
int EndAnimation = 180;
int lastEarned=0;
float helpTime=0;
BOOL processStop = NO;
int achivBlue = 0;
BOOL dialogShow = NO;
int totalcarrotsforach = 0;
BOOL achProcessRuns = NO;
BOOL highScore = NO;
int hearts=3;
//increases with all carrots gone
//int picture1 = 1;
//int score = 0;
//int seekernumber = 3;
//BOOL right = NO;*/
// HelloWorldLayer implementation*/

@implementation HelloWorldLayer
@synthesize spriteSheet = _spriteSheet;
@synthesize rabbit = _rabbit;
@synthesize babyrabbit = _babyrabbit;
@synthesize walkAction = _walkAction;
@synthesize moveAction = _moveAction;
@synthesize carrots = _carrots;
//@synthesize dog= _dog;
//@synthesize dogWalkAction = _dogWalkAction;
//@synthesize dogMoveAction = _dogMoveAction;
@synthesize progressbar = _progressbar;
@synthesize phycarrots = _phycarrots;
@synthesize dogs = _dogs;
@synthesize scoreShow = _scoreShow;
@synthesize scoreShadow = _scoreShadow;
@synthesize achievementBar = _achievementBar;
@synthesize eatables = _eatables;
@synthesize achievementAction = _achievementAction;
@synthesize achrequests = _achrequests;
@synthesize moving = _moving;
@synthesize screenimage = _screenimage;
@synthesize heartlist = _heartlist;
static HelloWorldLayer* instanceOfGameScene;
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
		[scene addChild:layer z:0];

 
    
	
	// add layer as a child to scene

	
	// return the scene
	return scene;
}


+(HelloWorldLayer*) sharedGameScene
{
	NSAssert(instanceOfGameScene != nil, @"GameScene instance not yet initialized!");
	return instanceOfGameScene;
}



#pragma mark - Init and Menu creating

- (void) returnToMain {
    CCScene *game = [BabyMenu scene];
    [[CCDirector sharedDirector] replaceScene:
	 [CCTransitionSlideInL transitionWithDuration:0.8f scene:game]];

}
- (void) returnToMenu:(id) sender{
    //CCScene *game = [BabyMenu scene];
    if (dialogShow == NO) {
        dialogShow = YES;
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"buttonef.wav"];
        }


        //NSLog(@"Dialog");
        [self unschedule:@selector(nextFrame:)];
        [self unschedule:@selector(progressOfBabysEating:)];
        [self unschedule:@selector(progressOfDogAndLevel:)];
        [self unschedule:@selector(progressOfEatableCarrots:)];
        [self unschedule:@selector(progressTheHunger:)];
        [self unschedule:@selector(generateCarrotsWithTime:)];
        for (Dog *mydog in _dogs) {
            [mydog stopAllActions];

        }
        [_rabbit stopAllActions];
        
        
        CCLayer *dialogLayer = [[DialogLayer alloc] initWithLayer:self];
        
        [self addChild:dialogLayer z:2];
    }

    
}
- (void) generateCarrotsWithTime:(id)sender{

    [self carrotGenerate:1];
    if ([self chanceWithNumber:90]) {
        [self carrotGenerate:10];
        
    }
}


- (NSString *)md5HexDigest:(NSString*)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH*2];
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

- (void) reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent
{
    GKAchievement *achievement = [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];
    if (achievement)
    {
        achievement.percentComplete = percent;
        [achievement reportAchievementWithCompletionHandler:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                if (error == NULL) {
                    NSLog(@"achivement Sent");
                } else {
                    NSLog(@"achievement Failed");
                }
            });
         }];
    }
}

- (void) reportScore: (int64_t) score forCategory: (NSString*) category
{
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
    scoreReporter.value = score;
    

    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if (error == NULL) {
                NSLog(@"Score Sent");
            } else {
                // If a score fails it will be added to the score queue
                
                //ScoreType score(int)-hash(for security reasons)
                NSString *nice = [self md5HexDigest:[NSString stringWithFormat:@"%itdg",score]];
                NSLog(@"scorer: %@",nice);
                NSString *scoretext = [NSString stringWithFormat:@"%i-",score];
                scoretext = [scoretext stringByAppendingString:nice];
                NSLog(@"scorer: %@",scoretext);
                [[NSUserDefaults standardUserDefaults] setObject:scoretext forKey:@"NotSent"];
                NSLog(@"Score Failed");
            }
        });
    }];
    
    
    

}
-(id) init
{


	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
   // SeekersWayPoints = [[NSMutableArray alloc] init];
    
	if( (self=[super init])) {
        
        instanceOfGameScene = self;
        
        
        
        
   
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        MCGoal = ccp(135,80);
        CCLabelTTF *goBack = [CCLabelTTF labelWithString:@">" fontName:@"Chalkduster" fontSize:30];
        
        achivBlue = 0;
        goBack.color = ccBLACK;
        
        CCMenuItemLabel *goButton = [CCMenuItemLabel itemWithLabel:goBack target:self selector:@selector(returnToMenu:)];
        
        CCMenu *menu = [CCMenu menuWithItems: goButton, nil];
        [menu setPosition:ccp(10,winSize.height-10)];
        [menu alignItemsVertically];
        hearts=3;
        achProcessRuns = NO;
        totalCarrots =0;
        helpTime=0;
        third = 0;
        frames = 0;
        picture = 1;
        carrotsThatInIt = 0;
        score = 0;
        totalCarrots = 0;
        dogFollow = 0;//1 means yes
        stockCarrots= 0;
        hunger = 100;
         hungerscale = 4;
        level = 1;
        lastEarned = 0;
        increaseVelocity = 0;
        generation = 0;
        carrotsThatWillbeEated = 0;
         end = NO;
         EndAnimation = 180;
        processStop = NO;
        dialogShow = NO;
         totalcarrotsforach = 0;
        self.phycarrots = [[NSMutableArray alloc] init];
        self.carrots = [[NSMutableArray alloc] init];
        self.dogs = [[NSMutableArray alloc] init];
        self.eatables = [[NSMutableArray alloc] init];
        self.achrequests = [[NSMutableArray alloc] init];
    
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Music"]==1) {
            [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"secondtrack.mp3"];

        }
        
        
        
        
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
      
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"game.plist"];
       // frame = [[CCSpriteFrameCache sharedSpriteFrameCache]  spriteFrameByName:@"background.png"];
        _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"game.pvr"];
        [self addChild:_spriteSheet];
        

        background = [CCSprite spriteWithSpriteFrameName:@"back.png"];
        background.tag = 1;
        background.anchorPoint = CGPointMake(0, 0);
        background.scale = 1;
        background.position = ccp(0,170);
        CCSprite *backland = [CCSprite spriteWithSpriteFrameName:@"front.png"];
        [backland setColor:ccWHITE];
        [backland setBlendFunc:(ccBlendFunc) { GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA }];
        backland.anchorPoint = CGPointMake(0,0);
   
        [background setColor:ccWHITE];
        [background setBlendFunc: (ccBlendFunc) { GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA }];
        [_spriteSheet addChild:background];
        [_spriteSheet addChild:backland];
   
        label = [CCLabelTTF labelWithString:@"Baby Rabbit" fontName:@"AmericanTypewriter-Bold" fontSize:20.0];
         label.position = ccp(274, 12);
       //label.anchorPoint = ccp(0,0);
        [label setColor:ccWHITE];
        [label setAnchorPoint: ccp(0, 0.5f)];
        label.tag = 3;
        [self addChild:label];
        
        
        mlabel= [CCLabelTTF labelWithString:@"Achievement Won! "fontName:@"Chalkduster" fontSize:18.0];
        mlabel.position = ccp(264, 305);
        [mlabel setColor:ccBLACK];
       
        
        
        
        
        alabel= [CCLabelTTF labelWithString:@"The Rabbit Hole!" fontName:@"Chalkduster" fontSize:18.0];
        alabel.position = ccp(264, 285);
        [alabel setColor:ccBLACK];

            

        
        CCSprite *rectangleprogress = [CCSprite spriteWithSpriteFrameName:@"progress.png"];
        rectangleprogress.position = ccp(375,45);
        rectangleprogress.scale = progressScale;
   
        
        self.progressbar = [CCSprite spriteWithSpriteFrameName:@"bar.png"];
        _progressbar.position = ccp(375,45);
        _progressbar.scale = progressScale;
        [_spriteSheet addChild:_progressbar];

        [_spriteSheet addChild:rectangleprogress];
        
        self.achievementBar = [CCSprite spriteWithSpriteFrameName:@"achievementquarter.png"];
        _achievementBar.position = ccp(240,300);
        _achievementBar.scale = 0.4;

        

        
        self.babyrabbit = [CCSprite spriteWithSpriteFrameName:@"rabbit-1.png"];
        _babyrabbit.tag=7;
        _babyrabbit.scale = 0.3;
        _babyrabbit.position = ccp(160,23);
        [_spriteSheet addChild:_babyrabbit];
        //Creating rabbit
        self.rabbit = [CCSprite spriteWithSpriteFrameName:@"rabbit-1.png"];
        _rabbit.tag = 2;
        _rabbit.scale = 0.35;
       // _rabbit.anchorPoint = CGPointMake(0, 0);
        _rabbit.position =  MCGoal;
        
        
        //Creating dog
        
        /*
        self.dog = [CCSprite spriteWithSpriteFrameName:@"dog-laugh.png"];
        _dog.tag = 4;
        _dog.position = ccp(winSize.width/2-50,winSize.height/2);
        _dog.scale = 0.35;*/
        self.scoreShow = [CCLabelTTF labelWithString:@"+" fontName:@"AmericanTypewriter-Bold" fontSize:13.0];
        _scoreShow.position = _rabbit.position;
        self.scoreShadow = [CCLabelTTF labelWithString:@"+" fontName:@"AmericanTypewriter-Bold" fontSize:13.0];
        _scoreShadow.position = _rabbit.position;
        _scoreShadow.color = ccBLACK;
        _scoreShadow.rotation = 10;
        _scoreShow.rotation = 10;
        _scoreShow.color = ccGREEN;
        _scoreShow.opacity = 0;
        _scoreShadow.opacity = 0;
        [self addChild:_scoreShadow];
        [self addChild:_scoreShow];
        
        
        
        
        /// Generating The Dogs 1 only now
        //-------------------------------------------------------------------------
     /*   Dog *firstDog = [Dog spriteWithSpriteFrameName:@"dog-laugh.png"];
        firstDog.position =  ccp(winSize.width/2-80,winSize.height/2);
        firstDog.scale = 0.35;
        
        NSMutableArray *dogAnimFrames = [NSMutableArray array];
        for(int i = 1; i <= 4; ++i) {
            
            [dogAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"dog-%i.png", i]]];
        }
        CCAnimation *dogWalkAnim = [CCAnimation animationWithFrames:dogAnimFrames delay:0.09f];
        
        firstDog.dogWalkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:dogWalkAnim restoreOriginalFrame:NO]];
        firstDog.rabbit = _rabbit;
     
        [firstDog dogMove];
        [_dogs addObject:firstDog];*/
        //--------------------------------------------------------------
                

        NSMutableArray *mypositions = self.generatePositions;

        for (int i = 0; i<[mypositions count]; ++i) {
            Carrot *carrot = [Carrot spriteWithSpriteFrameName:@"carrotplant.png"];
            carrot.epd = 0; //unknown now
            NSString *myString = [mypositions objectAtIndex:i ];
           // NSLog(@"%i",[mypositions count]);
            carrot.position = ccp([[[myString componentsSeparatedByString:@"-"] objectAtIndex:0] floatValue],[[[myString componentsSeparatedByString:@"-"] objectAtIndex:1] floatValue]);
            carrot.scale = 0.75;
            carrot.visible = NO;
            carrot.epd = 1;
            [_carrots addObject:carrot];
            [_spriteSheet addChild:carrot];
 
        }
        //Making carrots visible
        [self carrotGenerate:20]; //generates auto-randomly
        ///////

        
        /////////
       NSMutableArray *rabbitAnimFrames = [NSMutableArray array];
        self.heartlist = [NSMutableArray array];
        for(int i = 1; i <= 7; ++i) {

            [rabbitAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"rabbit-%i.png", i]]];
        }
        CCAnimation *walkAnim = [CCAnimation animationWithFrames:rabbitAnimFrames delay:0.05f];
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
        //[_rabbit runAction:_walkAction];
       /* CCAction *aAction ;
                      aAction =[CCSequence actions:   
                                
                                [CCMoveTo actionWithDuration:moveDuration position:apoint],
                                [CCDelayTime actionWithDuration:2.5],
                                [CCCallFunc actionWithTarget:self selector:@selector(achievementShowFinished)],
                                nil
                                ];*/
        //self.isTouchEnabled = YES;
        
        
        [_spriteSheet addChild:self.rabbit];
       // [_spriteSheet addChild:firstDog];
        int b = 0;
        while  (b<1){
        [self addADog];
            b+=1;
        }
        
        

        //[self addNewSprite:MCGoal.x y:250];
        [self addChild: menu];
        
        
        
        
        
        [self schedule:@selector(nextFrame:)];
        [self schedule: @selector(generateCarrotsWithTime:) interval:3];
        [self schedule: @selector(progressTheHunger:) interval:1.5];
        [self schedule: @selector(progressOfDogAndLevel:) interval:15];
     

      //  [[GKAchievementHandler defaultHandler] notifyAchievementTitle:@"Baby Rabbit" andMessage:@"Have three dogs in a single game"];
        mlabel.position = ccp(264, 355);
        alabel.position = ccp(264, 335);
        _achievementBar.position = ccp(240,350);
        
        [self addChild:alabel];
        [self addChild:mlabel];
        [_spriteSheet addChild:_achievementBar];
       // [self showAchievementWithString:@"First" anew:YES];
      //  [self showAchievementWithString:@"Second" anew:YES];
       // [self showAchievementWithString:@"Third" anew:YES];
        
        
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Control"]==1) {
            InputLayer* inputLayer = [InputLayer node];
            [self addChild:inputLayer z:1];
        }
        
        
        
        // heart adder
        Heart *aheart = [Heart spriteWithSpriteFrameName:@"heart.png"];
        aheart.heartType = 0;
        aheart.scale = 0.8;
        aheart.position = ccp(winSize.width-13,winSize.height-13);
        

        Heart *bheart = [Heart spriteWithSpriteFrameName:@"heart.png"];
        bheart.heartType = 0;
        bheart.scale = 0.8;
        bheart.position = ccp(winSize.width-33,winSize.height-13);
       
        Heart *cheart = [Heart spriteWithSpriteFrameName:@"heart.png"];
        cheart.heartType = 0;
        cheart.scale = 0.8;
        cheart.position = ccp(winSize.width-53,winSize.height-13);
      
        
        
        [_heartlist addObject:cheart];
        [_heartlist addObject:bheart];
        [_heartlist addObject:aheart];
        [_spriteSheet addChild:aheart];
        [_spriteSheet addChild:bheart];
        [_spriteSheet addChild:cheart];
	}
	return self;
}


 
- (void) runAllOfThem {
    [self schedule:@selector(nextFrame:)];
    [self schedule: @selector(generateCarrotsWithTime:) interval:3];
    [self schedule: @selector(progressTheHunger:) interval:1.5];
    
    [self schedule: @selector(progressOfDogAndLevel:) interval:15];
    
    for (Dog *mydog in _dogs) {
        [mydog stopAllActions];
        mydog.waitInterval = 0;
        [mydog dogMoveEnded];
    }
    dialogShow = NO;
    [self rabbitMoveEnded];
}

- (void) showAchievementWithString:(NSString *)achtext anew:(BOOL)newone{
    
    
    if (newone) {
        [_achrequests addObject:achtext];
    }
    
    [alabel setString:[_achrequests objectAtIndex:0]];
    //First pos
    //calculated pos
    /*
    mlabel.position = ccp(264, 305);
    alabel.position = ccp(264, 285);
    _achievementBar.position = ccp(240,300);
    
    
    //Goal positions 
    
    mlabel.position = ccp(264, 355);
    alabel.position = ccp(264, 335);
    _achievementBar.position = ccp(240,350);
    */
    if (achProcessRuns == NO) {
        achProcessRuns = YES;
        NSMutableArray *spThatMove = [NSMutableArray arrayWithObjects:mlabel,alabel,_achievementBar, nil];
        int x = 0;
        if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
            [[SimpleAudioEngine sharedEngine] playEffect:@"achwon.mp3"];
        }
        for (CCNode *sp in spThatMove) {
            CCAction *aAction;
            CGPoint apoint;
            
            switch (x) {
                case 0:
                    apoint = ccp(264, 305);
                    break;
                    
                case 1:
                    apoint =  ccp(264, 285);
                    break;
                    
                case 2:
                    apoint = ccp(240,300);
                    break;
            }
            float achvelo = (120.0)/3.0;
            CGPoint moveDifference = ccpSub(apoint, sp.position);
            float distanceToMove = ccpLength(moveDifference);
            float moveDuration = distanceToMove / achvelo;
            
            
            if (x==0) {
                aAction =[CCSequence actions:   
                          
                          [CCMoveTo actionWithDuration:moveDuration position:apoint],
                          [CCDelayTime actionWithDuration:2.5],
                          [CCCallFunc actionWithTarget:self selector:@selector(achievementShowFinished)],
                          nil
                          ];
                [sp runAction:aAction];
            }
            else {
                aAction =[CCSequence actions:   
                          
                          [CCMoveTo actionWithDuration:moveDuration position:apoint],
                          [CCDelayTime actionWithDuration:2.5],
                          nil
                          ];
                [sp runAction:aAction];
            }
            
            
            x +=1;
            //NSLog(@"action given");
        }

    }
          
}

- (void) achievementShowFinished{
    //First pos
    //calculated pos
    /*
     mlabel.position = ccp(264, 305);
     alabel.position = ccp(264, 285);
     _achievementBar.position = ccp(240,300);
     
     
     //Goal positions 
     
     mlabel.position = ccp(264, 355);
     alabel.position = ccp(264, 335);
     _achievementBar.position = ccp(240,350);
     */

    NSMutableArray *spThatMove = [NSMutableArray arrayWithObjects:mlabel,alabel,_achievementBar, nil];
    int x = 0;
    for (CCNode *sp in spThatMove) {
        CCAction *aAction;
        CGPoint apoint;
        
        switch (x) {
            case 0:
                apoint = ccp(264, 355);
                break;
                
            case 1:
                apoint =  ccp(264, 335);
                break;
                
            case 2:
                apoint = ccp(240,350);
                break;
        }
        float achvelo = (120.0)/3.0;
        CGPoint moveDifference = ccpSub(apoint, sp.position);
        float distanceToMove = ccpLength(moveDifference);
        float moveDuration = distanceToMove / achvelo;
        
        
        
        if (x==0) {
            
            aAction =[CCSequence actions:   
                      
                      [CCMoveTo actionWithDuration:moveDuration position:apoint],
                      [CCCallFunc actionWithTarget:self selector:@selector(achShowTotalyFinished)],
                      nil
                      ];
            [sp runAction:aAction];
        }
        else {
            
            aAction =[CCSequence actions:   
                      
                      [CCMoveTo actionWithDuration:moveDuration position:apoint],
                      nil
                      ];
            [sp runAction:aAction];
        }

        
        
        x +=1;
        //NSLog(@"action back");
    }
    
}
- (void) achShowTotalyFinished{
    if ([_achrequests count] != 0 && achProcessRuns == YES) [_achrequests removeObjectAtIndex:0]; 
    achProcessRuns = NO;
    //NSLog(@"List:%i",[_achrequests count]);
    
    
     //NSLog(@"Last List:%i",[_achrequests count]);
    if ([_achrequests count] != 0) {
          
        [self showAchievementWithString:[_achrequests objectAtIndex:0] anew:NO];
    }
}
- (void) progressOfEatableCarrots:(id)sender{ //babyrabbit eats one of them
    //[self reportAchievementIdentifier:@"12" percentComplete:100.0];
 
    generation -= 1;
    CCSprite *eat = [CCSprite spriteWithSpriteFrameName:@"carrot.png"];
    eat.position = ccp(MCGoal.x+(arc4random()%13)+1, MCGoal.y);
    eat.scale = 0.5;
    eat.rotation = (arc4random() % 360) +1;
    [self addChild:eat];
    [_eatables addObject:eat];
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
        [[SimpleAudioEngine sharedEngine] playEffect:@"carrotdrop.wav"];
    }
}

- (void) progressOfBabysEating:(id)sender{
    if ([_eatables count]>0 ) {
        CCSprite *sprite = [_eatables objectAtIndex:0];
        if ( sprite.position.y < 25.0) {
            
            if (third==0) {
                _babyrabbit.rotation += 1;
                if (_babyrabbit.rotation >= 30) {
                    third = 1;
                }
            }
            else {
                _babyrabbit.rotation -= 1;
                if (_babyrabbit.rotation <= 0) {
                    third = 0;
                }
                
                
                
            }
            
            [self removeChild:[_eatables objectAtIndex:0] cleanup:
             YES];
            [_eatables removeObjectAtIndex:0];
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
                [[SimpleAudioEngine sharedEngine] playEffect:@"eat.wav"];
            }   
            carrotsThatWillbeEated -=1;
            hunger = hunger + 1*(hungerscale/4);
            if (hunger>=100){
                hunger = 100;
                _progressbar.scaleX = 3.0;
                _progressbar.position = ccp(375,45);
                _babyrabbit.rotation = 0;
            }
            else {
                _progressbar.scaleX = (3.0/100)*(hunger);
                _progressbar.position = ccp(_progressbar.position.x - 1*(hungerscale/4), _progressbar.position.y);
                //_babyrabbit.rotation -= 9*carrotsThatInIt;
                
            }
            
            
            [self unschedule:@selector(progressTheHunger:)];
            [self schedule:@selector(progressOfBabysEating:) interval:1];
            
            
            
            
        }
    }
    else {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"rabbit-1.png"];
        [_babyrabbit setDisplayFrame:frame];
        _babyrabbit.rotation = 0;
        third = 0;
        [self schedule:@selector(progressTheHunger:) interval:1.5];
        [self unschedule:@selector(progressOfBabysEating:)];
        
        
    }
    



}

- (void) addAHeartCarrot {
    totalCarrots += 1;
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self generateRandoms:1]];
    for (int i = 0; i<1; ++i) {
        

        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"heartplant.png"];
        [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setDisplayFrame:frame];
        [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setEpd:4];
        
        [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setVisible:YES];
        
    }

}
- (void) progressOfDogAndLevel:(id)sender{
    if ([self chanceWithNumber:1000]==NO) {
        level=level+1;
        if (level%3==0) {
            [self addAHeartCarrot];
            [self addADog];
            [self carrotGenerate:(arc4random()%10)+4];
        }

    }
    if ([_dogs count]==3 && [[NSUserDefaults standardUserDefaults] integerForKey:@"13"] == 0) {
        [self showAchievementWithString:@"Three Dogs!" anew:YES];
        [self reportAchievementIdentifier:@"13" percentComplete:100];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"13"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if ([_dogs count]==6 && [[NSUserDefaults standardUserDefaults] integerForKey:@"14"] == 0) {
        [self showAchievementWithString:@"Six Dogs!" anew:YES];
        [self reportAchievementIdentifier:@"14" percentComplete:100];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"14"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if ([_dogs count]==10 && [[NSUserDefaults standardUserDefaults] integerForKey:@"18"] == 0) {
        [self showAchievementWithString:@"Ten DOGS!" anew:YES];
        [self reportAchievementIdentifier:@"18" percentComplete:100];
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"18"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
- (void) progressTheHunger:(id)sender{
    if ([_eatables count] == 0){
        
        hunger -= 2; //hunger starts for every 100 frame
        _progressbar.scaleX = (3.0/100)*(hunger);
        _progressbar.position = ccp(_progressbar.position.x + 2, _progressbar.position.y);
        //_babyrabbit.rotation += 9;

        
    }
}

-(void) checkRabbitTouchedCarrot{
   for (int i = 0; i<[self.carrots count]; ++i) {
      CGRect carrotRect = [[self.carrots objectAtIndex:i] boundingBox];
      CGRect rabbitRect = [_rabbit boundingBox];
      
      if (CGRectIntersectsRect(rabbitRect, carrotRect))
      {
          totalCarrots +=1;
          if ([[self.carrots objectAtIndex:i]  visible]) {
   
              [[self.carrots objectAtIndex:i] setVisible:NO];
              totalcarrotsforach +=1;
              if ([[self.carrots objectAtIndex:i] epd] == 3) {
                 // NSLog(@"Bad carrot!");
                  carrotsThatInIt -= 1;
                  [_rabbit stopAction:_moveAction];
                  _rabbit.position = [self WayPointMakerbyRadius:20.0 withSprite:_rabbit];
                  if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
                      [[SimpleAudioEngine sharedEngine] playEffect:@"badcarrot.wav"];
                  }
                   score -= 50; // corrected 0.6
                  [_scoreShow setString:[NSString stringWithFormat:@"-%i",50]];
                  [_scoreShadow setString:[NSString stringWithFormat:@"-%i",50]];
                  _scoreShadow.opacity = 255;
                  _scoreShow.opacity = 255;
                  _scoreShow.color = ccRED;

              }
              else if ([[self.carrots objectAtIndex:i] epd] == 2){
               //   [_dog stopAllActions];
              //    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] /spriteFrameByName:@"dog-laugh.png"];
          //        [_dog setDisplayFrame:frame];
           //       _dogmoving = FALSE;
          //        [self dogMove];
          //        waitInterval += 1.0; //power carrot
                  if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
                      [[SimpleAudioEngine sharedEngine] playEffect:@"blue.wav"];
                  }
                  [self sleepDogsSleep];
                  carrotsThatInIt += 2;
                   _scoreShow.color = ccGREEN;
                  lastEarned += 20;
                  [_scoreShow setString:[NSString stringWithFormat:@"+%i",lastEarned]];
                  [_scoreShadow setString:[NSString stringWithFormat:@"+%i",lastEarned]];
                  _scoreShadow.opacity = 255;
                  _scoreShow.opacity = 255;
                   score += 20;
                  if ([self chanceWithNumber:3]) {
                      [self carrotGenerate:(arc4random()%15)+3];
                  }
                  if ([[NSUserDefaults standardUserDefaults] integerForKey:@"17"] == 0) {
                      [self showAchievementWithString:@"Blue Carrot!" anew:YES];
                      [self reportAchievementIdentifier:@"17" percentComplete:100];
                      [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"17"];
                      [[NSUserDefaults standardUserDefaults] synchronize];
                  }
                  
                  if (achivBlue == 6 && [[NSUserDefaults standardUserDefaults] integerForKey:@"16"] == 0) {
                      [self showAchievementWithString:@"Blues!" anew:YES];
                      [self reportAchievementIdentifier:@"16" percentComplete:100];
                      [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"16"];
                      [[NSUserDefaults standardUserDefaults] synchronize];
                  }
                  achivBlue += 1;
              }
              else if ([[self.carrots objectAtIndex:i] epd] == 4){ //redish
                  if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
                      [[SimpleAudioEngine sharedEngine] playEffect:@"blue.wav"];
                  }

                  carrotsThatInIt += 5;
                  _scoreShow.color = ccGREEN;
                  lastEarned += 100;
                  [_scoreShow setString:[NSString stringWithFormat:@"+%i",lastEarned]];
                  [_scoreShadow setString:[NSString stringWithFormat:@"+%i",lastEarned]];
                  _scoreShadow.opacity = 255;
                  _scoreShow.opacity = 255;
                  score += 100;
                  [self increaseHeart];
                  
                  

                  
              }
              else if ([[self.carrots objectAtIndex:i] epd] == 1){
                  //   [_dog stopAllActions];
                  //    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] /spriteFrameByName:@"dog-laugh.png"];
                  //        [_dog setDisplayFrame:frame];
                  //       _dogmoving = FALSE;
                  //        [self dogMove];
                  //        waitInterval += 1.0; //power carrot
                  if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
                      [[SimpleAudioEngine sharedEngine] playEffect:@"carrottwo.wav"];
                  }
                  if (_scoreShow.opacity>0 && [[NSString stringWithFormat:@"%C",[[_scoreShow string] characterAtIndex:0] ] isEqualToString:@"+"]) {
                      score += [_scoreShow.string intValue]+lastEarned;
                      
                      lastEarned += 1;
                      [_scoreShow setString:[NSString stringWithFormat:@"+%i",lastEarned]];
                      [_scoreShadow setString:[NSString stringWithFormat:@"+%i",lastEarned]];
                      
                      
                  }
                  else {
                       score += 1;
                       lastEarned = 1;
                      [_scoreShow setString:[NSString stringWithFormat:@"+%i",lastEarned]];
                      [_scoreShadow setString:[NSString stringWithFormat:@"+%i",lastEarned]];
                     
                  }
                  
                   _scoreShow.color = ccGREEN;

                  _scoreShadow.opacity = 255;
                  _scoreShow.opacity = 255;
               
              }
              CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"carrotplant.png"];
              [[self.carrots objectAtIndex:i]  setDisplayFrame:frame];
              [[self.carrots objectAtIndex:i]  setEpd:1];
              
              [[self.carrots objectAtIndex:i] setVisible:NO];

             // NSLog(@"Rabbit ate %d. carrot!", i);
              carrotsThatInIt += 1;
            
              totalCarrots -= 1;
              
              

          }

          
      }

      
      
  }
 
}

- (void) onEnter {
    //changed 0.6
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Control"]==0) {
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    }
	[super onEnter];
}

- (void) onExit {
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Control"]==0) {
        [[CCTouchDispatcher sharedDispatcher] removeDelegate: self];
    }
	[super onExit];
}


- (UIImage*) takeAsUIImage
{
	CCDirector* director = [CCDirector sharedDirector];
	//CGSize size = [self contentSize];
    CGSize size = [[[CCDirector sharedDirector] runningScene] contentSize];
	//Create buffer for pixels
	GLuint bufferLength = size.width * size.height * 4;
	GLubyte* buffer = (GLubyte*)malloc(bufferLength);
    
	//Read Pixels from OpenGL
	glReadPixels(0, 0, size.width, size.height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
	//Make data provider with data.
	CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer, bufferLength, NULL);
    
	//Configure image
	int bitsPerComponent = 8;
	int bitsPerPixel = 32;
	int bytesPerRow = 4 * size.width;
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	CGImageRef iref = CGImageCreate(size.width, size.height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
    
	uint32_t* pixels = (uint32_t*)malloc(bufferLength);
	CGContextRef context = CGBitmapContextCreate(pixels, [director winSize].width, [director winSize].height, 8, [director winSize].width * 4, CGImageGetColorSpace(iref), kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
	CGContextTranslateCTM(context, 0, size.height);
	CGContextScaleCTM(context, 1.0f, -1.0f);
    

	switch ([[UIApplication sharedApplication] statusBarOrientation])
	{
            
        case UIInterfaceOrientationPortrait:
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            break;
		case UIDeviceOrientationLandscapeLeft:
			CGContextRotateCTM(context, CC_DEGREES_TO_RADIANS(-90));
			CGContextTranslateCTM(context, -size.height, 0);
			break;
		case UIDeviceOrientationLandscapeRight:
			CGContextRotateCTM(context, CC_DEGREES_TO_RADIANS(90));
			CGContextTranslateCTM(context, size.width * 0.5f, -size.height);
			break;
	}
    
	CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, size.width, size.height), iref);
	UIImage *outputImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    
	//Dealloc
	CGDataProviderRelease(provider);
	CGImageRelease(iref);
	CGContextRelease(context);
	free(buffer);
	free(pixels);
    NSLog(@"yep");
	return outputImage;
}

- (UIImage*)snapshot:(UIView*)eaglview
{
    GLint backingWidth, backingHeight;
    
    // Bind the color renderbuffer used to render the OpenGL ES view
    // If your application only creates a single color renderbuffer which is already bound at this point, 
    // this call is redundant, but it is needed if you're dealing with multiple renderbuffers.
    // Note, replace "_colorRenderbuffer" with the actual name of the renderbuffer object defined in your class.
  //  glBindRenderbufferOES(GL_RENDERBUFFER_OES, kEAGLColorFormatRGBA8);
   // glBindRenderbufferOES(GL_RENDERBUFFER_OES, kEAGLColorFormatRGBA8);
   // glBindRenderbuffer(<#GLenum target#>, <#GLuint renderbuffer#>)
    // Get the size of the backing CAEAGLLayer
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
    
    NSInteger x = 0, y = 0, width = backingWidth, height = backingHeight;
    NSInteger dataLength = width * height * 4;
    GLubyte *data = (GLubyte*)malloc(dataLength * sizeof(GLubyte));
    
    // Read pixel data from the framebuffer
    glPixelStorei(GL_PACK_ALIGNMENT, 4);
    glReadPixels(x, y, width, height, GL_RGBA, GL_UNSIGNED_BYTE, data);
    
    // Create a CGImage with the pixel data
    // If your OpenGL ES content is opaque, use kCGImageAlphaNoneSkipLast to ignore the alpha channel
    // otherwise, use kCGImageAlphaPremultipliedLast
    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef iref = CGImageCreate(width, height, 8, 32, width * 4, colorspace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast,
                                    ref, NULL, true, kCGRenderingIntentDefault);
    
    // OpenGL ES measures data in PIXELS
    // Create a graphics context with the target size measured in POINTS
    NSInteger widthInPoints, heightInPoints;
    if (NULL != UIGraphicsBeginImageContextWithOptions) {
        // On iOS 4 and later, use UIGraphicsBeginImageContextWithOptions to take the scale into consideration
        // Set the scale parameter to your OpenGL ES view's contentScaleFactor
        // so that you get a high-resolution snapshot when its value is greater than 1.0
        CGFloat scale = eaglview.contentScaleFactor;
        widthInPoints = width / scale;
        heightInPoints = height / scale;
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(widthInPoints, heightInPoints), NO, scale);
    }
    else {
        // On iOS prior to 4, fall back to use UIGraphicsBeginImageContext
        widthInPoints = width;
        heightInPoints = height;
        UIGraphicsBeginImageContext(CGSizeMake(widthInPoints, heightInPoints));
    }
    
    CGContextRef cgcontext = UIGraphicsGetCurrentContext();
    
    // UIKit coordinate system is upside down to GL/Quartz coordinate system
    // Flip the CGImage by rendering it to the flipped bitmap context
    // The size of the destination area is measured in POINTS
    CGContextSetBlendMode(cgcontext, kCGBlendModeCopy);
    CGContextDrawImage(cgcontext, CGRectMake(0.0, 0.0, widthInPoints, heightInPoints), iref);
    
    // Retrieve the UIImage from the current context
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // Clean up
    free(data);
    CFRelease(ref);
    CFRelease(colorspace);
    CGImageRelease(iref);
    
    return image;
}

#pragma mark - Heart Functions 



- (void) increaseHeart{
    if (hearts == 3) {
        //can not increase hearts
    }
    else if (hearts == 2) {
        
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"heart.png"];
        [[_heartlist objectAtIndex:0] setDisplayFrame:frame];
        [[_heartlist objectAtIndex:0] setHeartType:0];
        hearts +=1;
    }
    else if (hearts == 1) {
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"heart.png"];
        [[_heartlist objectAtIndex:1] setDisplayFrame:frame];
        [[_heartlist objectAtIndex:1] setHeartType:0];
        
        hearts +=1;
    }

}
- (void) decreaseHeart{
  
    [self sleepDogsSleep];
    if (hearts == 3) {
        NSLog(@"go");
        
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"deadheart.png"];
        [[_heartlist objectAtIndex:0] setDisplayFrame:frame];
        [[_heartlist objectAtIndex:0] setHeartType:1];
        

        hearts -=1;
    }
    else if (hearts == 2) {
        
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"deadheart.png"];
        [[_heartlist objectAtIndex:1] setDisplayFrame:frame];
        [[_heartlist objectAtIndex:1] setHeartType:1];
        
        hearts -=1;
    }
    else if (hearts == 1) {
      
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"deadheart.png"];
        [[_heartlist objectAtIndex:2] setDisplayFrame:frame];
        [[_heartlist objectAtIndex:2] setHeartType:1];
        NSLog(@"Die Rabbit Die");
        hearts -=1;
    }

}




#pragma mark - Level Touch Events Velocity etc.
- (void) nextFrame:(ccTime)dt {
    [self collisionDetect];
  //  NSLog(@"%f %f %f",mlabel.position.y,alabel.position.y,_achievementBar.position.y);
    helpTime += dt;
    if (helpTime==1000) helpTime =0;
    //NSLog(@"%i",totalcarrotsforach);
    frames = [[NSNumber numberWithFloat:helpTime*100] intValue];
   // NSLog(@"%i",frames);
    if (end) { // Game finished
        
        
        
        
        if (totalcarrotsforach == 0 && [[NSUserDefaults standardUserDefaults] integerForKey:@"15"] == 0) {
            [self showAchievementWithString:@"No Carrots!"anew:YES];
            [self reportAchievementIdentifier:@"15" percentComplete:100];
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"15"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        [self unschedule: @selector(generateCarrotsWithTime:)];
        [self unschedule: @selector(progressTheHunger:)];
        [self unschedule: @selector(progressOfDogAndLevel:)];
        [self unschedule: @selector(progressOfEatableCarrots:)];
        [self unschedule: @selector(progressOfBabysEating:)];
        [self sleepDogsSleep];
        if (EndAnimation==178) 
        {   
            [self reportScore:score forCategory:@"983720573960182"];
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"score"] !=nil) {
                NSString *mystring = [[NSUserDefaults standardUserDefaults] objectForKey:@"score"];
                if (score >=[mystring intValue]) {
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",score] forKey:@"score"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                }
            }
            else {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",score] forKey:@"score"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }

        }
        EndAnimation -= 2;
        
        _rabbit.rotation =180-EndAnimation;
        if (EndAnimation==0) {
          
            end = NO;
            GameOverScene *gameOverScene = [GameOverScene node];
            //self.screenimage = [self takeAsUIImage];
            self.screenimage = [self snapshot:[[CCDirector  sharedDirector] openGLView]];
            CGImageRef cgImage = [self.screenimage CGImage];
            
            // Make a new image from the CG Reference
             gameOverScene.layer.screenShot = [[UIImage alloc] initWithCGImage:cgImage];
            gameOverScene.layer.howmanydogs = [NSString stringWithFormat:@"%i",[_dogs count]];

            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"score"] !=nil) {
                NSString *mystring = [[NSUserDefaults standardUserDefaults] objectForKey:@"score"];
                if (score >=[mystring intValue]) {

                    [[[gameOverScene layer] emitter] setVisible:YES];
                     [[[gameOverScene layer] emitter1] setVisible:YES];
                    [gameOverScene.layer.label setString:[NSString stringWithFormat:@"New High Score: %i ",score ]];
                    gameOverScene.layer.highScore = YES;
             
                }
                else {
                    [[[gameOverScene layer] emitter] setVisible:NO];
                    [[[gameOverScene layer] emitter1] setVisible:NO];

                    [gameOverScene.layer.label setString:[NSString stringWithFormat:@"Score: %i ",score ]];
                }
            }

            
            [[CCDirector sharedDirector] replaceScene:gameOverScene];

        }
        
    }
    else {
        
        [[_dogs objectAtIndex:0] setRabbit:_rabbit];
        if (increaseVelocity > 0 ) increaseVelocity -= increaseVelocity/100;
        
        
        
        
        _scoreShow.position = ccp(_rabbit.position.x+13,_rabbit.position.y+12);
        _scoreShadow.position = ccp(_rabbit.position.x+12,_rabbit.position.y+11);
        
        if (_scoreShadow.opacity !=0) {
            _scoreShadow.opacity -= 3;
            _scoreShow.opacity -= 3;
        }
        else {
            _scoreShow.color = ccGREEN;
        }
        
        
        
        
        
        [self checkRabbitTouchedCarrot];
        
        
        score +=1;
        if (score>[[[NSUserDefaults standardUserDefaults] objectForKey:@"score"] intValue]) {
            label.color = ccGREEN;
        }
        [label setString:[NSString stringWithFormat:@"%i",score]];
        
        if ([self aDogCatchedMyRabbit]) {
            
            
           // NSLog(@"totalcarrotsforarch: %i", totalcarrotsforach);
            

            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
                [[SimpleAudioEngine sharedEngine] playEffect:@"gameover.wav"];
            }
         

            [self decreaseHeart];
             _rabbit.position = [self WayPointMakerbyRadius:50.0 withSprite:_rabbit];
            if (hearts==0) {
                end = YES;
           
                
                if ([[NSUserDefaults standardUserDefaults] integerForKey:@"15"] == 0 && totalcarrotsforach ==0) {
                    [self showAchievementWithString:@"No Carrots!" anew:YES];
                    [self reportAchievementIdentifier:@"15" percentComplete:100];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"15"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
            }
            else {
             
            }
            
        

            
            
        }
        
        if (hunger < 0){
            end = YES;
            
            NSLog(@"totalcarrotsforarch: %i", totalcarrotsforach);
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"15"] == 0 && totalcarrotsforach ==0) {
                [self showAchievementWithString:@"No Carrots!" anew:YES];
                [self reportAchievementIdentifier:@"15" percentComplete:100];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"15"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }

            /*
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"Sound"]==1) {
                [[SimpleAudioEngine sharedEngine] playEffect:@"gameover.wav"];
            }
            [self reportScore:score forCategory:@"983720573960182"];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"score"] !=nil) {
                NSString *mystring = [[NSUserDefaults standardUserDefaults] objectForKey:@"score"];
                if (score >=[mystring intValue]) {
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",score] forKey:@"score"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                }
            }
            else {
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",score] forKey:@"score"];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
             */
            
            
        }
        
        if ([self aPosition:_rabbit.position enteredToPosition:MCGoal withRadius:15]){ //giving carrots
            // NSLog(@"Put your carrots here!");

            if (carrotsThatInIt != 0) {
                if ([[NSUserDefaults standardUserDefaults] integerForKey:@"12"] == 0) {
                    [self showAchievementWithString:@"Rabbit Hole!" anew:YES];
                    [self reportAchievementIdentifier:@"12" percentComplete:100];
                    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%i",1] forKey:@"12"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                score += carrotsThatInIt*carrotsThatInIt;
                carrotsThatWillbeEated  += carrotsThatInIt;
                _scoreShow.color = ccGREEN;
                [_scoreShow setString:[NSString stringWithFormat:@"+%i",carrotsThatInIt*carrotsThatInIt]];
                [_scoreShadow setString:[NSString stringWithFormat:@"+%i",carrotsThatInIt*carrotsThatInIt]];
                _scoreShadow.opacity = 255;
                _scoreShow.opacity = 255;
                
                
                generation += carrotsThatInIt;
                
                
            }
            carrotsThatInIt = 0;
            
        }
        
        
     
        if ([_eatables count]>0) {
            CCSprite *sprite = [_eatables objectAtIndex:0];
            if ( sprite.position.y < 25.0) {
           
                if (third==0) {
                    _babyrabbit.rotation += 1;
                    if (_babyrabbit.rotation >= 30) {
                        third = 1;
                    }
                }
                else {
                    _babyrabbit.rotation -= 1;
                    if (_babyrabbit.rotation <= 0) {
                        third = 0;
                    }
                    
                    
                    
                }
                [self unschedule:@selector(progressTheHunger:)];
                [self schedule:@selector(progressOfBabysEating:) interval:1];
        
                                
            }
        }
        else {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"rabbit-1.png"];
            [_babyrabbit setDisplayFrame:frame];
            _babyrabbit.rotation = 0;
            third = 0;
            [self schedule:@selector(progressTheHunger:) interval:1.5];
            [self unschedule:@selector(progressOfBabysEating:)];
            
        }
        
        
        
        for (CCSprite *carrote in _eatables) {
            if (carrote.position.y>24.0) {
                carrote.position = ccp(carrote.position.x,carrote.position.y-1.0);
                
            }
        }
        if (generation != 0) {
            [self schedule:@selector(progressOfEatableCarrots:) interval:0.1];
                
            
        }
        else {
            [self unschedule:@selector(progressOfEatableCarrots:)];
        }
        
        
        

    }
    
    
       
    /*
    for (Dog *mydog in _dogs) {
        if ([self aPosition:_rabbit.position enteredToPosition:mydog.position withRadius:50]) {
            [mydog stopAllActions];
            [mydog dogMove];
        }
      
    }*/
}


- (void) stopBabyActions {
    
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (dialogShow==NO) {
          return YES;
    }
    
    
    
  return NO;
}

//0.6
/*
-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSArray *touchArray = [touches allObjects];
    
  //  UITouch *touchOne = [touchArray objectAtIndex:0];
   // CGPoint locationOne = [touchOne locationInView:[touchOne location]];
    
    //CODE
    
    if ( [touchArray count] > 1 ) {
       // UITouch *touchTwo = [touchArray objectAtIndex:1];
        //Location, CODE
        NSLog(@"nice");
    }
    
    //And so forth...

}*/

-(void) carrotGenerate:(int)number{
    totalCarrots += number;
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self generateRandoms:number]];
    for (int i = 0; i<number; ++i) {
        
        if ([self chanceWithNumber:30]) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"deadcarrotplant.png"];
            [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setDisplayFrame:frame];
            [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setEpd:3];
        }
        if ([self chanceWithNumber:60]) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"powerplant.png"];
            [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setDisplayFrame:frame];
            [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setEpd:2];
        }
        if ([self chanceWithNumber:30]) {
            CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"carrotplant.png"];
            [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setDisplayFrame:frame];
            [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setEpd:1];
        }
        [[_carrots objectAtIndex:[[array objectAtIndex:i]intValue] ] setVisible:YES];
        
    }
}
#pragma mark - Rabbit Move and Walk Functions

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    increaseVelocity += 160.0;
    if (increaseVelocity>2000) increaseVelocity = 2000;
    CGPoint touchLocation = [touch locationInView: [touch view]];		
    touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
    touchLocation = [self convertToNodeSpace:touchLocation];
    //new collision based system in 0.6 - 0.5
    touchLocation = [self canGO:touchLocation firstPos:_rabbit.position];
    
    float rabbitVelocity = (330.0+increaseVelocity/10.0)/3.0;
    CGPoint moveDifference = ccpSub(touchLocation, _rabbit.position);
    float distanceToMove = ccpLength(moveDifference);
    float moveDuration = distanceToMove / rabbitVelocity;
    
    if (moveDifference.x < 0) {
        _rabbit.flipX = NO;
    } else {
        _rabbit.flipX = YES;
    }    
    
    [_rabbit stopAction:_moveAction];
    
    if (!_moving) {
        [_rabbit runAction:_walkAction];
    }
    
    self.moveAction = [CCSequence actions:                          
                       [CCMoveTo actionWithDuration:moveDuration position:touchLocation],
                       [CCCallFunc actionWithTarget:self selector:@selector(rabbitMoveEnded)],
                       nil
                       ];
    
    
    [_rabbit runAction:_moveAction];   
    
    _moving = TRUE;
    
    
    
    
}

-(void)rabbitMoveEnded {
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"rabbit-1.png"];
    [_rabbit setDisplayFrame:frame];
    
    [_rabbit stopAction:_walkAction];
    
    _moving = FALSE;
    
    
}




#pragma mark - Utilities


- (BOOL) collisionOfSprite:(CCSprite *)sprite{
    // New collision logic brought you by tdgunes :)
    
    
    
    CGPoint pos = sprite.position;
    
    
    if ((pos.y-80<-(99/75)*(pos.x-84)) && pos.x <= 73.5) {
        
        return YES;
    
    }
    
   // if (pos.y<214.0 && pos.y>80.0 && (pos.y-80>-(99/75)*(pos.x-84))){
   //     return pos;
   // }
  //  else {
    if (pos.y>214.0) {
        return YES;
    }
    if (pos.y<80.0 && pos.x>74) {
        return YES;
    
        
    }
    
    
    if (pos.x<0) {
        return YES;
    }
    if (pos.x>480.0) {
        return YES;
    } 
    return NO;
    

    
}
- (void) collisionDetect{
    //TDG proudly presents :)
    // NSLog(@"firstpos: fx:%f fy:%f lastpos: lx:%f ly:%f",firstpos.x, firstpos.y, pos.x,pos.y);
    //Items that are considered to be included inside collision detection system
    // - rabbit
    // - dogs
    
    
    // New collision system both uses - (BOOL) collisionOfSprite and - (CGPoint) canGO when Touches - ON in options
    // 
    // rabbit collision
    if ([self collisionOfSprite:_rabbit]) {
      //  NSLog(@"collision");
         [_rabbit stopAllActions];
        _rabbit.position = [self positionFromSpriteThatWillBeFixedForTheCollisionDetection:_rabbit];
       
        _moving = NO;
        [self rabbitMoveEnded];
    
    }
    
    for (Dog *mydog in _dogs) {
        if ([self collisionOfSprite:mydog]) {
            mydog.position = [self positionFromSpriteThatWillBeFixedForTheCollisionDetection:mydog];
            [mydog stopAllActions];
            [mydog dogMoveEnded];     
        }
    }
      
}
- (CGPoint) positionFromSpriteThatWillBeFixedForTheCollisionDetection:(CCSprite *)sprite{
    CGPoint pos = sprite.position;
    float x = pos.x;
    float y = pos.y;
    
    if ((pos.y-80<-(99/75)*(pos.x-84)) && pos.x <= 73.5) {
        
        x +=1;
        
    }
    
    // if (pos.y<214.0 && pos.y>80.0 && (pos.y-80>-(99/75)*(pos.x-84))){
    //     return pos;
    // }
    //  else {
    if (pos.y>214.0) {
        y -=1;
    }
    if (pos.y<80.0 && pos.x>74) {
       
        y +=1;
        
    }
    
    
    if (pos.x<0) {
        x +=1 ;
    }
    if (pos.x>480.0) {
        x -=1;
    } 
    pos = ccp(x,y);
    return pos;
}

- (CGPoint) IamTheDogAndICatchedYourRabbit{
    for (Dog *mydog in _dogs) {
        if ([self aPosition:mydog.position enteredToPosition:_rabbit.position withRadius:1.0]) {
            return mydog.position;
        }
    }
    CGPoint adog;
    return adog;
}
- (BOOL) aDogCatchedMyRabbit{
    for (Dog *mydog in _dogs) {
        if ([self aPosition:mydog.position enteredToPosition:_rabbit.position withRadius:1.0]) {
            return YES;
        }
    }
    return NO;
}

- (void) sleepDogsSleep{
    for (Dog *mydog in _dogs) {
        [mydog stopAllActions];
        mydog.waitInterval +=3;
        [mydog dogMoveEnded];
    }

}
- (void) addADog{
    float x = (arc4random() % 20)+1;
    Dog *firstDog = [Dog spriteWithSpriteFrameName:@"dog-laugh.png"];
    firstDog.position =  ccp(230,210);
    firstDog.scale = dogScale;
    
    NSMutableArray *dogAnimFrames = [NSMutableArray array];
    for(int i = 1; i <= 4; ++i) {
        
        [dogAnimFrames addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"dog-%i.png", i]]];
    }
    CCAnimation *dogWalkAnim = [CCAnimation animationWithFrames:dogAnimFrames delay:0.09f];
    
    firstDog.dogWalkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:dogWalkAnim restoreOriginalFrame:NO]];
    firstDog.rabbit = _rabbit;
    firstDog.velocity += x;
    [firstDog dogMove];
    [_dogs addObject:firstDog];
    [_spriteSheet addChild:firstDog];
    
}
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

- (BOOL) randomWaitOK{
    int chance = (arc4random() % 10) + 1;
    if (chance == 4) {
        return NO;
    }
    else {
        return YES;
    }
    
}
- (CGPoint) WayPointMakerbyRadius:(float)radius withSprite:(CCSprite *)sprite
{
    CGPoint MCWayPoint;
    int x ;
    int y ;
    while (YES) {
        x = (arc4random() % 450) + 1;
        y = (arc4random() % 330) + 1;
        if ([self aPosition:ccp(x,y) enteredToPosition:sprite.position withRadius:radius]) {
            break;
        }
        
    }
    
    MCWayPoint = ccp(x,y);
    return (MCWayPoint);
}
- (BOOL) array:(NSMutableArray *)array hasThisString:(NSString *)mystring{
    for (int i = 0; i<[array count]; ++i) {
        if ([mystring isEqualToString:[array objectAtIndex:i]]) {
            return YES;
        }
    }
    return NO;
}

- (NSMutableArray *) generateRandoms:(int)number{
    NSMutableArray *randoms = [NSMutableArray array];
    for (int i=0; i<number; ++i) {
        int x = (arc4random() % 32) + 1;
        // NSLog(@"%i",x);
        if ([self array:randoms hasThisString:[NSString stringWithFormat:@"%i",x]]) {
            i=i-1;
            
            
        }
        else{
            [randoms addObject:[NSString stringWithFormat:@"%i",x]];
        }
        
    }
    return (randoms);
} 
//                       x1,y1               x2, y2
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
- (BOOL) chanceWithNumber:(int)number{
    int randomNumber = (arc4random() % number) + 1;
    if (randomNumber==2) return YES;
    else return NO;
    
}

- (CGRect)makeRect:(CCSprite *)mySprite
{
	return CGRectMake(mySprite.position.x - (mySprite.contentSize.width*mySprite.scale) /2, mySprite.position.y - (mySprite.contentSize.height*mySprite.scale) / 2, (mySprite.contentSize.width*mySprite.scale), (mySprite.contentSize.height*mySprite.scale));
}

- (NSMutableArray *) generatePositions{
    NSMutableArray *positions = [NSMutableArray array];
    CGSize winSize = [CCDirector sharedDirector].winSize;
    //First row
    for (int x=1; x<=9; ++x) {
        [positions addObject:[NSString stringWithFormat:@"%f-%f",winSize.width/2-260+x*50,winSize.height/2+40+x]];
    }
    //Second row
    for (int x=1; x<=8; ++x) {
        [positions addObject: [NSString stringWithFormat:@"%f-%f",winSize.width/2-200+x*50,winSize.height/2+10+x]];
    }
    //Third row
    for (int x=1; x<=9; ++x) {
        [positions addObject: [NSString stringWithFormat:@"%f-%f",winSize.width/2-240+x*50,winSize.height/2-20+x]];
    }
    //Fourth row
    for (int x=5; x<=11; ++x) {
        [positions addObject: [NSString stringWithFormat:@"%f-%f",winSize.width/2-260+x*44,winSize.height/2-55+x]];
    }
    return (positions);
    
}
@end
