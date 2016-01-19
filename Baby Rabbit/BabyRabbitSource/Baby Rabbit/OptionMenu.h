//
//  OptionMenu.h
//  Baby Rabbit
//
//  Created by Taha Doğan Güneş on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"


@interface OptionMenu : CCLayerColor
{
    

    
    
    
}




// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
- (void) returnBack;
- (void) gameCenterOnOff;
- (void) soundOnOff;
- (void) musicOnOff;
- (void) gameControl;
- (void) goToAbout;
- (void) resetAll;
@end
