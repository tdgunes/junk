//
//  PhotoCell.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCell : UITableViewCell
{
    NSString *rowNumber;
    UINavigationController *navigationController;
    NSString *photoType;
    NSMutableArray *moveObject;
    
    
    UIButton *columnOne;
    UIButton *columnSecond;
    UIButton *columnThird;
}
@property (nonatomic, retain) UINavigationController *navigationController;
@property (nonatomic, retain) NSString *rowNumber;
@property (nonatomic, retain) NSString *photoType;
@property (nonatomic, retain) NSMutableArray *moveObject;

@property (strong, nonatomic) IBOutlet UIButton *columnOne;
@property (strong, nonatomic) IBOutlet UIButton *columnSecond;
@property (strong, nonatomic) IBOutlet UIButton *columnThird;

@property (strong, nonatomic) IBOutlet UILabel *columnOneTitle;
@property (strong, nonatomic) IBOutlet UILabel *columnSecondTitle;
@property (strong, nonatomic) IBOutlet UILabel *columnThirdTitle;

- (IBAction) buttonClicked:(id)sender;

@end
