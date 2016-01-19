//
//  ActPDFViewController.m
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ActPDFViewController.h"

@interface ActPDFViewController ()

@end

@implementation ActPDFViewController
@synthesize webView, documentName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadDocument:documentName inView:webView];
;
    // Do any additional setup after loading the view from its nib.
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)loadDocument:(NSString*)adocumentName inView:(UIWebView*)awebView
{
    NSString *path = [[NSBundle mainBundle] pathForResource:adocumentName ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [awebView loadRequest:request];
}

// Calling -loadDocument:inView:


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
