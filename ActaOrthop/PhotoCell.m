//
//  PhotoCell.m
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#include <QuartzCore/QuartzCore.h>
#import "PhotoCell.h"
#import "ActDetailGridViewController.h"
#import "ActArticleTableViewController.h"
#import "ActArticleObject.h"

@implementation PhotoCell
@synthesize columnOne, columnSecond, columnThird;
@synthesize columnOneTitle, columnSecondTitle, columnThirdTitle;
@synthesize rowNumber,navigationController;
@synthesize photoType;
@synthesize moveObject;

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

- (IBAction) buttonClicked:(id)sender
{
    if ([photoType isEqualToString:@"detail"]) {
        NSLog(@"row:%i button:%i", [rowNumber intValue],[sender tag]); 
        ActDetailGridViewController *detailViewController = [[ActDetailGridViewController alloc] initWithNibName:@"ActDetailGridViewController" bundle:nil];
        detailViewController.volObjects =[[NSMutableArray alloc] init];
        

        int x = 0;
        switch ([sender tag]) {
            case 1:
                x=1;
                detailViewController.myTitle = [columnOneTitle text];
                break;
            case 2:
                x=2;
                detailViewController.myTitle = [columnSecondTitle text];
                break;
            case 3:
                x=3;
                detailViewController.myTitle = [columnThirdTitle text];
                break;
         
        }
        for (ActVolObject *actvol in [moveObject objectAtIndex:x-1]) {
            [detailViewController.volObjects addObject:actvol];
        }
        
        //detailViewController.myTitle = [NSString stringWithFormat:@"row:%i button:%i", [rowNumber intValue],[sender tag]];
        
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
    else if ([photoType isEqualToString:@"article"]) {
        
         ActArticleTableViewController *detailViewController = [[ActArticleTableViewController alloc] initWithNibName:@"ActArticleTableViewController" bundle:nil];
        detailViewController.articleObjects =[[NSMutableArray alloc] init];
        
        int x = 0;
        switch ([sender tag]) {
            case 1:
                x=1;
                detailViewController.myTitle = [columnOneTitle text];
                break;
            case 2:
                x=2;
                detailViewController.myTitle = [columnSecondTitle text];
                break;
            case 3:
                x=3;
                detailViewController.myTitle = [columnThirdTitle text];
                break;
                
        }

        for (ActArticleObject *actvol in [moveObject objectAtIndex:x-1]) {
            [detailViewController.articleObjects addObject:actvol];
        }
        
        [self.navigationController pushViewController:detailViewController animated:YES];
        NSLog(@"row:%i button:%i", [rowNumber intValue],[sender tag]); 
    }

}

@end
