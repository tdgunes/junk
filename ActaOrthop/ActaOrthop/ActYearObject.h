//
//  ActYearObject.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActYearObject : NSObject{
    NSString *_yearName;
    NSMutableArray *_vols;

}
@property (nonatomic, retain) NSString *yearName;
@property (nonatomic, retain) NSMutableArray *vols;


@end
