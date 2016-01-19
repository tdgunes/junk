//
//  ActVolObject.m
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActVolObject.h"

@implementation ActVolObject

@synthesize articles = _articles;
@synthesize volName = _volName;


-(id) init{
    self = [super init];
    if(self){//always use this pattern in a constructor.
        
    }
    return self;
}
@end
