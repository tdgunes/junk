//
//  ActVolObject.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActVolObject : NSObject
{
    NSString *_volName;
    NSMutableArray *_articles;

}

@property (nonatomic, retain) NSString *volName;
@property (nonatomic, retain) NSMutableArray *articles;

@end
