//
//  Carrot.h
//  MissileComp
//
//  Created by Taha Doğan Güneş on 2/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCSprite.h"
#import "cocos2d.h"

@interface Carrot : CCSprite {
    int _epd; // types of carrot 1. eatable normal 2. powerful carrot 3. dead carrot
}

@property (nonatomic, assign) int epd;

- (void) setEpd:(int)number;
@end
