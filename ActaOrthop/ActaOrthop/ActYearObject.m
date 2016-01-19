//
//  ActYearObject.m
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActYearObject.h"

@implementation ActYearObject
@synthesize yearName = _yearName;
@synthesize vols = _vols;

/*
- (id)initWithName:(NSString *)name andWithArray:(NSMutableArray *) array
{

    self.yearName = name;
    self.vols = array;
    
    return self;
}*/
-(id) init{
    self = [super init];
    if(self){//always use this pattern in a constructor.

    }
    return self;
}
@end
