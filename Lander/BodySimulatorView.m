//
//  BodySimulatorView.m
//  Lander
//
//  Created by Luka Miljak on 07/06/14.
//  Copyright (c) 2014 Luka Miljak. All rights reserved.
//

#import "BodySimulatorView.h"
#import "Assembly.h"

@interface BodySimulatorView()
@property (strong, nonatomic) Assembly *assembly;
@end

@implementation BodySimulatorView

- (Assembly *)assembly {
    if (!_assembly) {

        // cabin
        CGPoint pointsCabin[8] = {  CGPointMake(-20.0, 0.0),
                                    CGPointMake(-40.0, 20.0),
                                    CGPointMake(-40.0, 40.0),
                                    CGPointMake(-20.0, 60.0),
                                    CGPointMake(20.0, 60.0),
                                    CGPointMake(40.0, 40.0),
                                    CGPointMake(40.0, 20.0),
                                    CGPointMake(20.0, 0.0)};
        Body *cabin = [[Body alloc] initWithPoints:pointsCabin
                                   numberOfPoints:sizeof(pointsCabin)/sizeof(CGPoint)
                                       closedPath:YES
                                             mass:100.0 centerOfMass:CGPointMake(0.0, 30) andMomentOfInertia:10.0];
        
        // service module
        CGPoint pointsModule[4] = { CGPointMake(-40.0, 60.0),
                                    CGPointMake(-40.0, 90.0),
                                    CGPointMake(40.0, 90.0),
                                    CGPointMake(40.0, 60.0),};
        Body *sModule = [[Body alloc] initWithPoints:pointsModule
                             numberOfPoints:sizeof(pointsModule)/sizeof(CGPoint)
                                 closedPath:YES
                                       mass:150.0 centerOfMass:CGPointMake(0.0, 75.0) andMomentOfInertia:10.0];
        
        // left leg
        CGPoint pointsLeftLeg[8] = {    CGPointMake(-40.0, 75.0),
                                        CGPointMake(-55.0, 105.0),
                                        CGPointMake(-55.0, 120.0),
                                        CGPointMake(-65.0, 120.0),
                                        CGPointMake(-45.0, 120.0),
                                        CGPointMake(-55.0, 120.0),
                                        CGPointMake(-55.0, 105.0),
                                        CGPointMake(-20.0, 90.0)};
        Body *lLeg = [[Body alloc] initWithPoints:pointsLeftLeg
                             numberOfPoints:sizeof(pointsLeftLeg)/sizeof(CGPoint)
                                 closedPath:NO
                                       mass:10.0 centerOfMass:CGPointMake(-40.0, 90.0) andMomentOfInertia:10.0];
        
        // right leg
        
        CGPoint pointsRightLeg[8] = {   CGPointMake(40.0, 75.0),
                                        CGPointMake(55.0, 105.0),
                                        CGPointMake(55.0, 120.0),
                                        CGPointMake(65.0, 120.0),
                                        CGPointMake(45.0, 120.0),
                                        CGPointMake(55.0, 120.0),
                                        CGPointMake(55.0, 105.0),
                                        CGPointMake(20.0, 90.0)};
        Body *rLeg = [[Body alloc] initWithPoints:pointsRightLeg
                             numberOfPoints:sizeof(pointsRightLeg)/sizeof(CGPoint)
                                 closedPath:NO
                                       mass:10.0 centerOfMass:CGPointMake(40.0, 90.0) andMomentOfInertia:10.0];
        
        // service module
        CGPoint pointsMotor[4] = {  CGPointMake(-5.0, 90.0),
                                    CGPointMake(-15.0, 110.0),
                                    CGPointMake(15.0, 110.0),
                                    CGPointMake(5.0, 90.0)};
        Body *sMotor = [[Body alloc] initWithPoints:pointsMotor
                                      numberOfPoints:sizeof(pointsMotor)/sizeof(CGPoint)
                                          closedPath:YES
                                                mass:0.0 centerOfMass:CGPointMake(0.0, 100.0) andMomentOfInertia:10.0];
        
        
        NSArray *bodies = @[cabin, sModule, lLeg, rLeg, sMotor];
        _assembly = [[Assembly alloc] initWithBodies:bodies];
        
        NSLog(@"assebly calculated center of mass: (%f, %f)", self.assembly.com.x, self.assembly.com.y);
        _assembly.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        
    }
    return _assembly;
}

- (void)updateAssembly:(NSTimer *)timer {
    [self.assembly setAngle:self.assembly.angle + 0.04];
    [self setNeedsDisplay];
}

- (void)setup {
    self.backgroundColor =[UIColor blackColor];
    //[NSTimer scheduledTimerWithTimeInterval:0.04
    //                                 target:self
    //                               selector:@selector(updateAssembly:)
    //                               userInfo:nil
    //                                repeats:YES];
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)fillSceneInContext:(CGContextRef)context {
    [self.assembly drawInContext:context];
}

- (void)drawRect:(CGRect)rect
{
    // setup context
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    [[UIColor whiteColor] setStroke];
    
    // fill scene with paths
    [self fillSceneInContext:context];
    
    // context stroke
    CGContextStrokePath(context);
}

- (void)rotate:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [sender translationInView:self];
            [self.assembly setAngle:self.assembly.angle + translation.y / 100];
        [self setNeedsDisplay];
        [sender setTranslation:CGPointZero inView:self];
    }
}

- (void)thrust:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"thrust started");
    }
    else if (sender.state == UIGestureRecognizerStateEnded ||
             sender.state == UIGestureRecognizerStateFailed) {
        NSLog(@"thrust ended");
    }
}

@end
