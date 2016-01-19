//
//  ArticleCell.m
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ArticleCell.h"
#import "ActPDFViewController.h"
@implementation ArticleCell
@synthesize articleLabel,authorLabel,yearNoLabel,navigationController;
@synthesize favoriteButton;
@synthesize rowNumber;
@synthesize favorited;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction) getPDF:(id)sender{
    NSLog(@"row:%i getPDF", [rowNumber intValue]);
    
    
    ActPDFViewController *detailViewController = [[ActPDFViewController alloc] initWithNibName:@"ActPDFViewController" bundle:nil];
    detailViewController.navigationItem.title = articleLabel.text;
    detailViewController.documentName=  @"document.pdf" ;
     [navigationController pushViewController:detailViewController animated:YES];
}
- (IBAction) getAbstract:(id)sender{
     NSLog(@"row:%i getAbstract", [rowNumber intValue]);
    
    ActPDFViewController *detailViewController = [[ActPDFViewController alloc] initWithNibName:@"ActPDFViewController" bundle:nil];
    detailViewController.navigationItem.title =@"Abstract";
    
    detailViewController.documentName = @"example.html" ;
    
    [navigationController pushViewController:detailViewController animated:YES];
    
  
}
- (IBAction) favorite:(id)sender{
     NSLog(@"row:%i favorite", [rowNumber intValue]);
    if (favorited == YES) {
        favorited = NO;
        [favoriteButton setHidden:NO];
    }
    else {
        favorited = YES;

        favoriteButton.highlighted = YES;
        [self performSelector:@selector(highlightButton:) withObject:sender afterDelay:0.0];
    }
}
- (void)highlightButton:(UIButton *)b { 
    [b setHighlighted:YES];
}

@end
