//
//  ActArticleObject.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActArticleObject : NSObject{
    NSString *_articleName;
    NSString *_articleYear;
    NSString *_articleAuthors;
    NSString *_articleVol;
    NSString *_articlePDFLink;

    
}

@property (nonatomic, retain) NSString *articleName;
@property (nonatomic, retain) NSString *articleYear;
@property (nonatomic, retain) NSString *articleAuthors;
@property (nonatomic, retain) NSString *articleVol;
@property (nonatomic, retain) NSString *articlePDFLink;


@end
