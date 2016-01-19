//
//  ActArticleTableViewController.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActArticleTableViewController : UITableViewController
{
         NSString *myTitle;
         NSMutableArray *_articleObjects;
}
@property (nonatomic, retain) NSString *myTitle;
@property (nonatomic, retain) NSMutableArray *articleObjects;
@end
