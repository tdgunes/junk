//
//  ActPDFViewController.h
//  ActaOrthop
//
//  Created by Taha Doğan Güneş on 7/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActPDFViewController : UIViewController
{
	UIWebView	*webView;
	NSString    *documentName;
}
-(void)loadDocument:(NSString*)documentName inView:(UIWebView*)webView;
@property (nonatomic, retain) IBOutlet UIWebView	*webView;
@property (nonatomic, retain) NSString *documentName;

@end
