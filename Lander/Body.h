//
//  Body.h
//  Lander
//
//  Created by Luka Miljak on 07/06/14.
//  Copyright (c) 2014 Luka Miljak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Body : NSObject

@property (nonatomic) float mass;       // body mass
@property (nonatomic) CGPoint com;      // center of the mass point in body coordinate system
@property (nonatomic) float moi;        // moment of inertia
@property (nonatomic) CGPoint position;
@property (nonatomic) float angle;
@property (nonatomic) CGPoint origin;

- (instancetype)initWithPoints:(CGPoint *)points
                numberOfPoints:(size_t)number
                    closedPath:(BOOL)closed
                  mass:(float)mass
          centerOfMass:(CGPoint)com
    andMomentOfInertia:(float)moi;

- (instancetype)initWithCircleWithCenterAt:(CGPoint)center
                        withRadius:(CGFloat)r
                              mass:(float)m
                      centerOfMass:(CGPoint)com
                andMomentOfInertia:(float)moi;

- (void)drawInContext:(CGContextRef)context;

@end
