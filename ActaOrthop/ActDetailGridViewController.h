//
//  ActDetailGridViewController.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCell.h"
#import "ActVolObject.h"
#import "ActYearObject.h"
@interface ActDetailGridViewController : UITableViewController
{
     NSString *myTitle;
     NSMutableArray *_volObjects;
     
    
}
@property (nonatomic, retain) NSString *myTitle;

@property (nonatomic, retain) NSMutableArray *volObjects;
@end
