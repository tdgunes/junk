//
//  ActFavoriteTableViewController.m
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActFavoriteTableViewController.h"
#import "ArticleCell.h"
#import "ActArticleObject.h"
@interface ActFavoriteTableViewController ()

@end

@implementation ActFavoriteTableViewController
@synthesize articleObjects = _articleObjects;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 93.0;
    //Customization
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.702 green:0.765 blue:0.871 alpha:1]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.title =@"Favorites";
    self.articleObjects = [[NSMutableArray alloc] init];
    
    ActArticleObject *art1 = [[ActArticleObject alloc] init];
    
    art1.articleName = @"Reconstruction of humeral diaphyseal non-unions with vascularized fibular graft";
    art1.articleAuthors =@"Tulgar Toros, Kemal Ozaksar,	 Tahir Sadık Sugun,	 Fuat Ozerkan";
    art1.articleYear = @"2012";
    art1.articleVol = @"Vol 46, No 3";
    art1.articlePDFLink = @"http://www.aott.org.tr/index.php/aott/article/download/5490/3218";
    [_articleObjects addObject:art1];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.articleObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleCell" owner:self options:NULL];
        cell = (ArticleCell *) [nib objectAtIndex:0];
        //customize part
        cell.navigationController = self.navigationController;
        cell.rowNumber = [NSString stringWithFormat:@"%i",[indexPath row]];
        cell.articleLabel.text = [[self.articleObjects objectAtIndex:[indexPath row]] articleName];
        cell.authorLabel.text = [[self.articleObjects objectAtIndex:[indexPath row]] articleAuthors];
        cell.yearNoLabel.text = [NSString stringWithFormat:@"%@ - %@",[[self.articleObjects objectAtIndex:[indexPath row]] articleYear],[[self.articleObjects objectAtIndex:[indexPath row]] articleVol]];
        cell.favoriteButton.highlighted = YES;
        cell.favorited = YES;
        
    }
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
