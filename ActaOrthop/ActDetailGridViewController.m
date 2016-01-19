//
//  ActDetailGridViewController.m
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActDetailGridViewController.h"
#import "PhotoCell.h"
#import "ActVolObject.h"
@interface ActDetailGridViewController ()

@end

@implementation ActDetailGridViewController

@synthesize myTitle;
@synthesize volObjects = _volObjects;

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

    [self.tableView setBackgroundColor:[UIColor colorWithRed:0.702 green:0.765 blue:0.871 alpha:1]];
    self.navigationItem.title = myTitle;
    self.tableView.rowHeight = 140.0;
    NSLog(@"vols:%i",[_volObjects count]);
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
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self lastRow];
}

- (int) lastRow{
    if (([_volObjects count]%3)==0) {
        return ([_volObjects count]/3);
    }
    else {
        return (([_volObjects count] + (3-[_volObjects count]%3))/3);
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
            switch ([_volObjects count]%3) {
                case 0:
                    cell.columnOneTitle.text = [[self.volObjects objectAtIndex:indexint] volName];
                    cell.columnSecondTitle.text = [[self.volObjects objectAtIndex:indexint+1] volName];
                    cell.columnThirdTitle.text = [[self.volObjects objectAtIndex:indexint+2] volName];
                    
                    [cell.moveObject addObject:[[self.volObjects objectAtIndex:indexint] articles]];
                    [cell.moveObject addObject:[[self.volObjects objectAtIndex:indexint+1] articles]];
                    [cell.moveObject addObject:[[self.volObjects objectAtIndex:indexint+2] articles]];
                    
                    break;
                case 2:
                    cell.columnOneTitle.text = [[self.volObjects objectAtIndex:indexint] volName];
                    cell.columnSecondTitle.text = [[self.volObjects objectAtIndex:indexint+1] volName];
                    
                    
                    
                    [cell.moveObject addObject:[[self.volObjects objectAtIndex:indexint] articles]];
                    [cell.moveObject addObject:[[self.volObjects objectAtIndex:indexint+1] articles]];

                    cell.columnThird.hidden = YES;
                    cell.columnThirdTitle.hidden =YES;
                    
                    break;
                case 1:
                    

                    
                    
                    cell.columnOneTitle.text = [[self.volObjects objectAtIndex:indexint] volName];
                    
                    [cell.moveObject addObject:[[self.volObjects objectAtIndex:indexint] articles]];

                    cell.columnSecond.hidden = YES;
                    cell.columnSecondTitle.hidden =YES;
                    cell.columnThird.hidden = YES;
                    cell.columnThirdTitle.hidden =YES;
                    break;
                    
            }
        }
        else {
            cell.columnOneTitle.text = [[self.volObjects objectAtIndex:[indexPath row]] volName];
            cell.columnSecondTitle.text = [[self.volObjects objectAtIndex:[indexPath row]+1] volName];
            cell.columnThirdTitle.text = [[self.volObjects objectAtIndex:[indexPath row]+2] volName];
            
            
            [cell.moveObject addObject:[[self.volObjects objectAtIndex:[indexPath row]] articles]];

            [cell.moveObject addObject:[[self.volObjects objectAtIndex:[indexPath row]+1] articles]];

            [cell.moveObject addObject:[[self.volObjects objectAtIndex:[indexPath row]+2] articles]];

        }
        
        
        
        
        //cell.rowOneTitle.text =  [NSString stringWithFormat:@"r:%i b:1",[indexPath row]];
        //cell.rowSecondTitle.text =  [NSString stringWithFormat:@"r:%i b:2",[indexPath row]];
        //cell.rowThirdTitle.text =  [NSString stringWithFormat:@"r:%i b:3",[indexPath row]];
        
        cell.photoType = @"article";
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
