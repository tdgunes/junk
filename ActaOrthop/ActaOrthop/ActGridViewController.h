//
//  ActGridViewController.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActGridViewController : UITableViewController{
    NSMutableArray *_yearObjects;
}

@property (nonatomic, retain) NSMutableArray *yearObjects;


- (int) lastRow;
@end
