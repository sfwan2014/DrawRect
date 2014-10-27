//
//  AViewController.h
//  DrawWall
//
//  Created by gll on 12-12-28.
//  Copyright (c) 2012年 gll. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface AViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIButton *ColorButton;
-(IBAction)remove:(id)sender;
-(IBAction)back:(id)sender;
-(IBAction)clear:(id)sender;
-(IBAction)changeColors:(id)sender;
- (IBAction)colorSet:(id)sender;
-(IBAction)changeWidth:(id)sender;
-(IBAction)widthSet:(id)sender;
- (IBAction)saveScreen:(id)sender;
@end
