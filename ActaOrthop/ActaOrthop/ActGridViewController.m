//
//  ActGridViewController.m
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 6/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActGridViewController.h"


// Great TDG Library
#import "PhotoCell.h" 
// Custom PhotoCell
#import "ActDetailGridViewController.h"
// a GridView Detail
#include <QuartzCore/QuartzCore.h>
// Custom Library
#import "ActArticleObject.h"
#import "ActVolObject.h"
#import "ActYearObject.h"

@interface ActGridViewController ()

@end

@implementation ActGridViewController

@synthesize yearObjects = _yearObjects;

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
    
    self.tableView.rowHeight = 140.0;
    self.navigationItem.title = @"All Issues"; 
    
    ActYearObject *aYear = [[ActYearObject alloc] init];
    aYear.yearName = @"2012";
    
    ActVolObject *vol1 = [[ActVolObject alloc] init];
    vol1.volName = @"Vol 46, No 3";
    vol1.articles = [[NSMutableArray alloc] init];
    
    
    //Customization
    //[self.tableView setBackgroundColor:[UIColor colorWithRed:0.859 green:0.933 blue:0.718 alpha:1] /*#dbeeb7*/];
    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.702 green:0.765 blue:0.871 alpha:1]]; /*#b3c3de*/
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0.502 blue:0.933 alpha:1] /*#226922*/;
    
    ActArticleObject *art1 = [[ActArticleObject alloc] init];
    
    art1.articleName = @"Reconstruction of humeral diaphyseal non-unions with vascularized fibular graft";
    art1.articleAuthors =@"Tulgar Toros, Kemal Ozaksar,	 Tahir Sadık Sugun,	 Fuat Ozerkan";
    art1.articleYear = @"2012";
    art1.articleVol = @"Vol 46, No 3";
    art1.articlePDFLink = @"http://www.aott.org.tr/index.php/aott/article/download/5490/3218";
    [vol1.articles addObject:art1];
    
    ActArticleObject *art2 = [[ActArticleObject alloc] init];
    
    art2.articleName = @"Minimally invasive plate osteosynthesis (MIPO) in diaphyseal humerus and proximal humerus fractures";
    art2.articleAuthors =@"Neslihan Aksu, Sinan Karaca, Ayhan Nedim Kara, Zekeriya Ugur Isiklar";
    art2.articleYear = @"2012";
    art2.articleVol = @"Vol 46, No 3";
    art2.articlePDFLink = @"http://www.aott.org.tr/index.php/aott/article/download/5490/3218";
    [vol1.articles addObject:art2];
    
    
    
    ActArticleObject *art3 = [[ActArticleObject alloc] init];
    
    art3.articleName = @"The results of minimally invasive percutaneous plate osteosynthesis (MIPPO) in distal and diaphyseal tibial fractures";
    art3.articleAuthors =@"Mehmet Atıf Erol Aksekili, Ismail Celik, Arslan Kagan Arslan, Tughan Kalkan, Mahmut Ugurlu";
    art3.articleYear = @"2012";
    art3.articleVol = @"Vol 46, No 3";
    art3.articlePDFLink = @"http://www.aott.org.tr/index.php/aott/article/download/5490/3218";
    [vol1.articles addObject:art3];
    
    
    //-------------------------------------------
    
    ActVolObject *vol2 = [[ActVolObject alloc] init];
    vol2.articles = [[NSMutableArray alloc] init];
    
    vol2.volName = @"Vol 46, No 2";
    
    ActArticleObject *art4 = [[ActArticleObject alloc] init];
    
    art4.articleName = @"Reconstruction of humeral diaphyseal non-unions with vascularized fibular graft";
    art4.articleAuthors =@"Tulgar Toros, Kemal Ozaksar,	 Tahir Sadık Sugun,	 Fuat Ozerkan";
    art4.articleYear = @"2012";
    art4.articleVol = @"Vol 46, No 3";
    art4.articlePDFLink = @"http://www.aott.org.tr/index.php/aott/article/download/5490/3218";
    [vol2.articles addObject:art4];
    
    ActArticleObject *art5 = [[ActArticleObject alloc] init];
    
    art5.articleName = @"Minimally invasive plate osteosynthesis (MIPO) in diaphyseal humerus and proximal humerus fractures";
    art5.articleAuthors =@"Neslihan Aksu, Sinan Karaca, Ayhan Nedim Kara, Zekeriya Ugur Isiklar";
    art5.articleYear = @"2012";
    art5.articleVol = @"Vol 46, No 3";
    art5.articlePDFLink = @"http://www.aott.org.tr/index.php/aott/article/download/5490/3218";
    [vol2.articles addObject:art5];
    
    
    
    ActArticleObject *art6 = [[ActArticleObject alloc] init];
    
    art6.articleName = @"The results of minimally invasive percutaneous plate osteosynthesis (MIPPO) in distal and diaphyseal tibial fractures";
    art6.articleAuthors =@"Mehmet Atıf Erol Aksekili, Ismail Celik, Arslan Kagan Arslan, Tughan Kalkan, Mahmut Ugurlu";
    art6.articleYear = @"2012";
    art6.articleVol = @"Vol 46, No 3";
    art6.articlePDFLink = @"http://www.aott.org.tr/index.php/aott/article/download/5490/3218";
    [vol2.articles addObject:art6];

    //--------------------------
    
    
    ActVolObject *vol3 = [[ActVolObject alloc] init];
    vol3.volName = @"Vol 46, No 1";
    
    

    
    
    
    
    ActVolObject *vol4 = [[ActVolObject alloc] init];
    vol4.volName = @"vol4";
    ActVolObject *vol5 = [[ActVolObject alloc] init];
    vol5.volName = @"vol5";
    ActVolObject *vol6 = [[ActVolObject alloc] init];
    vol6.volName = @"vol6";

    ActYearObject *bYear = [[ActYearObject alloc] init];
    

    bYear.yearName = @"2011";
    ActYearObject *cYear= [[ActYearObject alloc] init];
    cYear.yearName = @"2010";
    ActYearObject *dYear= [[ActYearObject alloc] init];
    dYear.yearName = @"2009";
    ActYearObject *eYear= [[ActYearObject alloc] init];
    eYear.yearName = @"2008";
    ActYearObject *fYear= [[ActYearObject alloc] init];
    fYear.yearName = @"2007";
    self.yearObjects = [[NSMutableArray alloc] init];
    
    aYear.vols = [[NSMutableArray alloc] init];
    bYear.vols = [[NSMutableArray alloc] init];
    cYear.vols = [[NSMutableArray alloc] init];
        dYear.vols = [[NSMutableArray alloc] init];
        eYear.vols = [[NSMutableArray alloc] init];
    [aYear.vols addObject:vol1];
    [aYear.vols addObject:vol2];/*
    [aYear.vols addObject:vol3];
    [aYear.vols addObject:vol4];

    [aYear.vols addObject:vol5];
    [aYear.vols addObject:vol6];*/

    
    [_yearObjects addObject:aYear];
    [_yearObjects addObject:bYear];
        [_yearObjects addObject:cYear];
        [_yearObjects addObject:dYear];
        [_yearObjects addObject:eYear];
    [bYear.vols addObject:vol1];
    [bYear.vols addObject:vol2];
    [bYear.vols addObject:vol1];

    [cYear.vols addObject:vol1];
    [cYear.vols addObject:vol2];
    [cYear.vols addObject:vol1];
    [cYear.vols addObject:vol1];
    [cYear.vols addObject:vol2];
    [cYear.vols addObject:vol1];

    [cYear.vols addObject:vol1];
    [dYear.vols addObject:vol1];
    [eYear.vols addObject:vol2];
    [cYear.vols addObject:vol3];
    [cYear.vols addObject:vol4];
    [cYear.vols addObject:vol5];
    [cYear.vols addObject:vol6];
    NSLog(@"total years: %i",[self.yearObjects count]);


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
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
    return [self lastRow];
}

/*
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return [indexPath row] * 40; // your dynamic height...
}
*/
- (int) lastRow{
    if (([_yearObjects count]%3)==0) {
        return ([_yearObjects count]/3);
    }
    else {
        return (([_yearObjects count] + (3-[_yearObjects count]%3))/3);
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Cell" owner:self options:NULL];
        
//cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    
   
        
        cell = (PhotoCell *) [nib objectAtIndex:0];
        cell.rowNumber = [NSString stringWithFormat:@"%i",[indexPath row]];
   
        cell.moveObject = [[NSMutableArray alloc] init];

        if ([self lastRow]==([indexPath row]+1)) {
            int indexint = [indexPath row]*3;
            switch ([_yearObjects count]%3) {
                case 0:
                    cell.columnOneTitle.text = [[self.yearObjects objectAtIndex:indexint] yearName];
                    cell.columnSecondTitle.text = [[self.yearObjects objectAtIndex:indexint+1] yearName];
                    cell.columnThirdTitle.text = [[self.yearObjects objectAtIndex:indexint+2] yearName];
                    [cell.moveObject addObject:[[self.yearObjects objectAtIndex:indexint] vols]];
                    [cell.moveObject addObject:[[self.yearObjects objectAtIndex:indexint+1] vols]];
                    [cell.moveObject addObject:[[self.yearObjects objectAtIndex:indexint+2] vols]];


                    break;
                case 2:
                    cell.columnOneTitle.text = [[self.yearObjects objectAtIndex:indexint] yearName];
                    cell.columnSecondTitle.text = [[self.yearObjects objectAtIndex:indexint+1] yearName];
                    cell.columnThird.hidden = YES;
                    cell.columnThirdTitle.hidden =YES;
                    [cell.moveObject addObject:[[self.yearObjects objectAtIndex:indexint] vols]];
                    [cell.moveObject addObject:[[self.yearObjects objectAtIndex:indexint+1] vols]];




                    break;
                case 1:
                    cell.columnOneTitle.text = [[self.yearObjects objectAtIndex:indexint] yearName];
                    [cell.moveObject addObject:[[self.yearObjects objectAtIndex:indexint] vols]];

                    cell.columnSecond.hidden = YES;
                    cell.columnSecondTitle.hidden =YES;
                    cell.columnThird.hidden = YES;
                    cell.columnThirdTitle.hidden =YES;
                   
                    break;

            }
        }
        else {

            cell.columnOneTitle.text = [[self.yearObjects objectAtIndex:[indexPath row]] yearName];
            cell.columnSecondTitle.text = [[self.yearObjects objectAtIndex:[indexPath row]+1] yearName];        
            cell.columnThirdTitle.text = [[self.yearObjects objectAtIndex:[indexPath row]+2] yearName];
            
            [cell.moveObject addObject:[[self.yearObjects objectAtIndex:[indexPath row]] vols]];
            [cell.moveObject addObject:[[self.yearObjects objectAtIndex:[indexPath row]+1] vols]];
            [cell.moveObject addObject:[[self.yearObjects objectAtIndex:[indexPath row]+2] vols]];
                    }
        

        
        

        //cell.rowOneTitle.text =  [NSString stringWithFormat:@"r:%i b:1",[indexPath row]];
        //cell.rowSecondTitle.text =  [NSString stringWithFormat:@"r:%i b:2",[indexPath row]];
        //cell.rowThirdTitle.text =  [NSString stringWithFormat:@"r:%i b:3",[indexPath row]];
        cell.photoType = @"detail";
        cell.navigationController = self.navigationController;
    }
    
                    
                    
    //NSUInteger row = [indexPath row];
    //cell.textLabel.text = @"aa";
    
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
     // NSLog(@"%i", [indexPath row]);
    
     // Navigation logic may go here. Create and push another view controller.
     
    
     // ...
     // Pass the selected object to the new view controller.
    
     
}

@end
