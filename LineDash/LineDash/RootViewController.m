//
//  RootViewController.m
//  LineDash
//
//  Created by changjian on 13-12-12.
//  Copyright (c) 2013年 changjian. All rights reserved.
//

#import "RootViewController.h"
#import "DashView.h"

@interface RootViewController ()

@end

@implementation RootViewController

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

    DashView *view = [[DashView alloc] initWithFrame:CGRectMake(0, 70, 320, 300)];
    view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:view selector:@selector(addPiont) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
