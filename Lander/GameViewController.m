//
//  GameViewController.m
//  Lander
//
//  Created by Luka Miljak on 04/06/14.
//  Copyright (c) 2014 Luka Miljak. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (IBAction)returnToMainScreen:(UITapGestureRecognizer *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// hide status bar
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
