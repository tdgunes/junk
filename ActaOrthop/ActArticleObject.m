//
//  ActArticleObject.m
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActArticleObject.h"

@implementation ActArticleObject

@synthesize articleName = _articleName;


@synthesize articleYear =_articleYear;
@synthesize articleAuthors =_articleAuthors;
@synthesize articleVol =_articleVol;
@synthesize articlePDFLink =_articlePDFLink;


-(id) init{
    self = [super init];
    if(self){//always use this pattern in a constructor.
        
    }
    return self;
}
@end
