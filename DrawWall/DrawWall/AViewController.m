//
//  AViewController.m
//  DrawWall
//
//  Created by gll on 12-12-28.
//  Copyright (c) 2012年 gll. All rights reserved.
//

#import "AViewController.h"
#import "MyView.h"
@interface AViewController ()
@property (strong,nonatomic)  MyView *drawView;
@property (assign,nonatomic)  BOOL buttonHidden;
@property (assign,nonatomic)  BOOL widthHidden;
@end

@implementation AViewController
//保存线条颜色
static NSMutableArray *colors;
- (void)viewDidLoad
{
    [super viewDidLoad];
    colors=[[NSMutableArray alloc]initWithObjects:[UIColor greenColor],[UIColor blueColor],[UIColor redColor],[UIColor blackColor],[UIColor whiteColor], nil];
    CGRect viewFrame=self.view.frame;
    self.buttonHidden=YES;
    self.widthHidden=YES;
    self.drawView=[[MyView alloc]initWithFrame:viewFrame];
    [self.drawView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview: self.drawView];
    [self.view sendSubviewToBack:self.drawView];
	// Do any additional setup after loading the view, typically from a nib.
}
-(IBAction)remove:(id)sender{
    [ self.drawView revocation];
}
-(IBAction)back:(id)sender{
    [ self.drawView refrom];
}
-(IBAction)clear:(id)sender{
    [self.drawView clear];
}
-(IBAction)changeColors:(id)sender{
    if (self.buttonHidden==YES) {
        for (int i=1; i<6; i++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            button.hidden=NO;
            self.buttonHidden=NO;
        }
    }else{
        for (int i=1; i<6; i++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            button.hidden=YES;
            self.buttonHidden=YES;
        }
    
    }
    
    
}
-(IBAction)changeWidth:(id)sender{
    if (self.widthHidden==YES) {
        for (int i=11; i<15; i++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            button.hidden=NO;
            self.widthHidden=NO;
        }
    }else{
        for (int i=11; i<15; i++) {
            UIButton *button=(UIButton *)[self.view viewWithTag:i];
            button.hidden=YES;
            self.widthHidden=YES;
        }
        
    }

}
- (IBAction)widthSet:(id)sender {
    UIButton *button=(UIButton *)sender;
    [self.drawView setlineWidth:button.tag-10];
}

- (IBAction)saveScreen:(id)sender {
    
    for (int i=1; i<16;i++) {
        UIView *view=[self.view viewWithTag:i];
        if ((i>=1&&i<=5)||(i>=10&&i<=15)) {
            if (view.hidden==YES) {
                continue;
            }
        }     
        view.hidden=YES;
        if(i>=1&&i<=5){
            self.buttonHidden=YES;
        }
        if(i>=10&&i<=15){
            self.widthHidden=YES;
        }
    }
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    for (int i=1;i<16;i++) {
        if ((i>=1&&i<=5)||(i>=11&&i<=14)) {
            continue;
        }
        UIView *view=[self.view viewWithTag:i];
        view.hidden=NO;
    }
    //截屏成功
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:@"Save OK" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
  [alertView show];
  [alertView release];
}
- (IBAction)colorSet:(id)sender {
    UIButton *button=(UIButton *)sender;
    [self.drawView setLineColor:button.tag-1];
    self.ColorButton.backgroundColor=[colors objectAtIndex:button.tag-1];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [_ColorButton release];
    [super dealloc];
}
@end
