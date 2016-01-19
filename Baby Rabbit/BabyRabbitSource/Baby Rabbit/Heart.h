//
//  Heart.h
//  Baby Rabbit
//
//  Created by Taha Doğan Güneş on 3/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Heart : CCSprite {
    int _heartType;
}

@property (nonatomic, assign) int heartType;



@end

