//
//  ArticleCell.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UITableViewCell
{
    UILabel *articleLabel;
    UILabel *authorLabel;
    UILabel *yearNoLabel;
    NSString *rowNumber;
     UINavigationController *navigationController;
    UIButton *favoriteButton;
    BOOL favorited;
    
}

@property BOOL favorited;
@property (nonatomic, retain) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) IBOutlet UILabel *articleLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearNoLabel;
@property (nonatomic, retain) NSString *rowNumber;
@property (nonatomic, retain) UINavigationController *navigationController;


- (IBAction) getPDF:(id)sender;
- (IBAction) getAbstract:(id)sender;
- (IBAction) favorite:(id)sender;
- (void)highlightButton:(UIButton *)b;
@end
