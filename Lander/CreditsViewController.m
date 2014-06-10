//
//  CreditsViewController.m
//  Lander
//
//  Created by Luka Miljak on 04/06/14.
//  Copyright (c) 2014 Luka Miljak. All rights reserved.
//

#import "CreditsViewController.h"

@interface CreditsViewController ()
@property (strong, nonatomic) IBOutlet UIView *creditsView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) UIGravityBehavior *gravityBehavior;
@property (strong, nonatomic) UICollisionBehavior *collisionBehavior;

// model
@property (strong, nonatomic) NSMutableArray *creditItems;

@end

@implementation CreditsViewController

#pragma mark - Getters/Setters

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.creditsView];
    }
    return _animator;
}

- (UIGravityBehavior *)gravityBehavior {
    if (!_gravityBehavior) {
        _gravityBehavior = [[UIGravityBehavior alloc] init];
        [self.animator addBehavior:_gravityBehavior];
    }
    return _gravityBehavior;
}

- (UICollisionBehavior *)collisionBehavior {
    if (!_collisionBehavior) {
        _collisionBehavior = [[UICollisionBehavior alloc] init];
        _collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        [self.animator addBehavior:_collisionBehavior];
    }
    return _collisionBehavior;
}

- (NSMutableArray *)creditItems {
    if (!_creditItems) {
        _creditItems = [[NSMutableArray alloc] initWithArray:@[@"Author", @"Luka", @"Miljak",
                                                               @"Version", @"1.0",
                                                               @"NO", @"MORE", @"SWIPE",
                                                               @"to", @"return"]];
    }
    return _creditItems;
}

#pragma mark - Actions

- (IBAction)returnToMainScreen:(UISwipeGestureRecognizer *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)dropSomething:(UITapGestureRecognizer *)sender {
    [self dropItemFrom:self.creditItems];
}

#pragma mark - Utility methods

- (void)dropItemFrom:(NSMutableArray *)items {
    if (items.count && [[items firstObject] isKindOfClass:[NSString class]]) {
    
        NSString *label = [items firstObject];
        [self dropCreditWithLabel:label];
        
        [items removeObjectAtIndex:0];
    }
}

- (void)dropCreditWithLabel:(NSString *)label {
    CGRect frame;
    CGSize size = {100, 20};
    frame.origin.x = (arc4random() % (int)(self.creditsView.frame.size.width) / 2) + (int)(self.creditsView.frame.size.width) / 4;
    frame.origin.y = 0;
    frame.size = size;
    UILabel *labelView = [[UILabel alloc] initWithFrame:frame];
    labelView.text = label;
    labelView.textAlignment = NSTextAlignmentCenter;
    labelView.textColor = [UIColor whiteColor];
    labelView.backgroundColor = [UIColor clearColor];
    labelView.font = [labelView.font fontWithSize:30];
    [labelView sizeToFit];
    
    [self.creditsView addSubview:labelView];
    [self.gravityBehavior addItem:labelView];
    [self.collisionBehavior addItem:labelView];
}

#pragma mark - View delegate methods
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

- (void)viewDidAppear:(BOOL)animated {
    [self dropCreditWithLabel:@"Double tap"];
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
