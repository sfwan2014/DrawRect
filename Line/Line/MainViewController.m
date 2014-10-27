//
//  MainViewController.m
//  Line
//
//  Created by changjian on 13-12-11.
//  Copyright (c) 2013年 changjian. All rights reserved.
//

#import "MainViewController.h"
#import "LineView.h"

@interface MainViewController ()

@end

@implementation MainViewController

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

    LineView *view = [[LineView alloc] initWithFrame:CGRectMake(0, 70, 320, 290)];
    view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
