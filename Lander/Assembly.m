//
//  Assembly.m
//  Lander
//
//  Created by Luka Miljak on 08/06/14.
//  Copyright (c) 2014 Luka Miljak. All rights reserved.
//

#import "Assembly.h"

@implementation Assembly

@synthesize bodies = _bodies;
@synthesize position = _position;
@synthesize com = _com;
@synthesize angle = _angle;

#pragma mark - Properties
- (void)setBodies:(NSSet *)bodies {
    _bodies = [bodies mutableCopy];
}

- (NSMutableSet *)bodies {
    if (!_bodies) {
        _bodies = [[NSMutableSet alloc] init];
    }
    return _bodies;
}

- (void)setPosition:(CGPoint)newPosition {
    _position.x = newPosition.x;
    _position.y = newPosition.y;
    
    for (Body *body in self.bodies) {
        body.position = CGPointMake(_position.x, _position.y);
    }
}

- (void)setAngle:(float)angle {
    _angle = angle;
    for (Body *body in self.bodies) {
        body.angle = _angle;
    }
}


#pragma mark - initialization

- (void)calculateParameters {
    // calculate mass for assembly
    for (Body *body in self.bodies) {
        self.mass += body.mass;
    }
    
    // calculate center of mass for assembly
    for (Body *body in self.bodies) {
        self.com = CGPointMake(self.com.x + body.mass * body.com.x, self.com.y + body.mass * body.com.y);
    }
    self.com = CGPointMake(self.com.x / self.mass, self.com.y / self.mass);

}

- (instancetype)initWithBodies:(NSArray *)bodies {
    
    self = [super init];
    
    if (self) {
        self.bodies = [NSMutableSet setWithArray:bodies];
        self.mass = 0.0;
        self.com = CGPointMake(0, 0);
        
        // calculate assembly parameters (mass, com ...)
        [self calculateParameters];
        
        // position body parts in respect to calculated com
        for (Body *body in self.bodies) {
            body.origin = CGPointMake(self.com.x, self.com.y);
            body.position = CGPointMake(body.position.x, body.position.y);
        }
    }
    
    return self;
}

#pragma mark - custom methods
- (void)drawInContext:(CGContextRef)context {
    for (Body *body in self.bodies) {
        [body drawInContext:context];
    }
}

- (void)addBody:(Body *)body {
    [self.bodies addObject:body];
    [self calculateParameters];
}

- (void)removeBody:(Body *)body {
    [self calculateParameters];
}



@end