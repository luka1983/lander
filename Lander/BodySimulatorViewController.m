//
//  BodySimulatorViewController.m
//  Lander
//
//  Created by Luka Miljak on 07/06/14.
//  Copyright (c) 2014 Luka Miljak. All rights reserved.
//

#import "BodySimulatorViewController.h"

@interface BodySimulatorViewController ()
@property (weak, nonatomic) IBOutlet UIView *bodySimulatorView;
@property (strong, nonatomic) UIPanGestureRecognizer *rotateGesture;
@property (strong, nonatomic) UILongPressGestureRecognizer *thrustGesture;

@end

@implementation BodySimulatorViewController

- (void)returnToMainScreen:(UITapGestureRecognizer *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)setBodySimulatorView:(UIView *)bodySimulatorView {
    NSLog(@"Adding control views");
    _bodySimulatorView = bodySimulatorView;

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bodySimulatorView.bounds.size.width / 2, self.bodySimulatorView.bounds.size.height)];
    [self.bodySimulatorView addSubview:subview];
    self.rotateGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.bodySimulatorView action:@selector(rotate:)];
    [subview addGestureRecognizer:self.rotateGesture];

    
    subview = [[UIView alloc] initWithFrame:CGRectMake(self.bodySimulatorView.bounds.size.width / 2, 0, self.bodySimulatorView.bounds.size.width / 2, self.bodySimulatorView.bounds.size.height)];
    [self.bodySimulatorView addSubview:subview];
    self.thrustGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self.bodySimulatorView action:@selector(thrust:)];
    self.thrustGesture.minimumPressDuration = 0.04;
    [subview addGestureRecognizer:self.thrustGesture];
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

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
//shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
 //   if (gestureRecognizer==self.thrustGesture && otherGestureRecognizer==self.rotateGesture)
  //      return YES;
 //   if (gestureRecognizer==self.rotateGesture && otherGestureRecognizer==self.thrustGesture)
  //      return YES;
 //   return NO;
//}

@end
