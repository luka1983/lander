//
//  Body.m
//  Lander
//
//  Created by Luka Miljak on 07/06/14.
//  Copyright (c) 2014 Luka Miljak. All rights reserved.
//

#import "Body.h"

@interface Body()
@property (nonatomic) CGMutablePathRef pathMutable;
@property (nonatomic) CGPathRef path;
@property (nonatomic) CGPathRef positionedPath;
@property (nonatomic) BOOL pathClosed;
@end


@implementation Body

@synthesize position = _position;
@synthesize com = _com;
@synthesize origin = _origin;

void MyCGPathApplierFunc(void *info, const CGPathElement *element) {
    //NSLog(@"found element of type %d", element->type);
    //if (element->type == kCGPathElementAddLineToPoint)
       // NSLog(@"this is line from prevous point to (%f, %f)", element->points[0].x, element->points[0].y);
}


#pragma mark - Properties

- (CGMutablePathRef)pathMutable {
    if (!_pathMutable) {
        _pathMutable = CGPathCreateMutable();
    }
    return _pathMutable;
}

- (CGPathRef)path {
    if (!_path) {
        _path = CGPathCreateCopy(self.pathMutable);
        CGPathRelease(self.pathMutable);
    }
    return _path;
}

- (CGPathRef)positionedPath {
    if (!_positionedPath) {
        _positionedPath = CGPathCreateMutable();
    }
    return _positionedPath;
}

- (void)setPosition:(CGPoint)newPosition {
    // update position
    _position = CGPointMake(newPosition.x, newPosition.y);
    NSLog(@"updating body wtih new position (%f, %f)", _position.x, _position.y);
}

- (void)setOrigin:(CGPoint)origin {
    // update position
    _origin = CGPointMake(origin.x, origin.y);
}

- (void)setCom:(CGPoint)newCom {
    // update center of mass
    _com = CGPointMake(newCom.x, newCom.y);
}


#pragma mark - Initialization

- (instancetype)initWithPoints:(CGPoint *)points
                numberOfPoints:(size_t)number
                    closedPath:(BOOL)closed
                  mass:(float)mass
          centerOfMass:(CGPoint)com
    andMomentOfInertia:(float)moi {
    
    self = [super init];
    
    if (self) {
        self.mass = mass;
        self.com = com;
        self.moi = moi;
        self.pathClosed = closed;
        self.position = CGPointMake(0.0, 0.0);
        self.angle = 0.0;
        
        CGPathAddLines(self.pathMutable, NULL, points, number);
        //NSLog(@"number of points to add:%lu", number);
        
    }
    
    return self;
    
}

- (instancetype)initWithCircleWithCenterAt:(CGPoint)center
                                withRadius:(CGFloat)r
                                      mass:(float)mass
                              centerOfMass:(CGPoint)com
                        andMomentOfInertia:(float)moi {
    
    self = [super init];
    
    if (self) {
        self.mass = mass;
        self.com = com;
        self.moi = moi;
        self.position = CGPointMake(0.0, 0.0);
        self.angle = 0.0;
        
        CGPathAddArc(self.pathMutable, NULL, center.x, center.y, r, 0, 2 * M_PI, NO);
    }
    
    return self;
    
}

#pragma mark - Custom

- (void)drawInContext:(CGContextRef)context {
    
    CGPathRef oldPositionedPath = self.positionedPath;
    
    // translate to origin
    CGAffineTransform transform = CGAffineTransformMakeTranslation(-self.origin.x, -self.origin.y);
    self.positionedPath = CGPathCreateCopyByTransformingPath(self.path, &transform);
    
    // rotate by angle
    transform = CGAffineTransformMakeRotation(self.angle);
    self.positionedPath = CGPathCreateCopyByTransformingPath(self.positionedPath, &transform);
    
    // translate to position
    transform = CGAffineTransformMakeTranslation(self.position.x, self.position.y);
    self.positionedPath = CGPathCreateCopyByTransformingPath(self.positionedPath, &transform);
    
    //CGPathApply(self.positionedPath, NULL, MyCGPathApplierFunc);
    CGContextAddPath(context, self.positionedPath);
    
    if (self.pathClosed)
        CGContextClosePath(context);
    
    CGPathRelease(oldPositionedPath);
    
}


@end
