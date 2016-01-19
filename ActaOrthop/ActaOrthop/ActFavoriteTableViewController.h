//
//  ActFavoriteTableViewController.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActFavoriteTableViewController : UITableViewController
{

    NSMutableArray *_articleObjects;
}

@property (nonatomic, retain) NSMutableArray *articleObjects;
@end
