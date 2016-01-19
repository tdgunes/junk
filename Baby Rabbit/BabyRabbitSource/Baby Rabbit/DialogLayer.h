//
//  DialogLayer.h
//  Baby Rabbit
//
//  Created by Taha Doğan Güneş on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "HelloWorldLayer.h"
@interface DialogLayer : CCLayerColor

{
    
   HelloWorldLayer *_parentLayer;
}
@property (nonatomic, retain) CCLayer *parentLayer;
- (void) soundOnOff;
- (void) musicOnOff;
- (void) toTheMenu;
- (void) continueGame;
-(id) initWithLayer:(HelloWorldLayer *)parentLayer;
@end
