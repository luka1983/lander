//
//  Assembly.h
//  Lander
//
//  Created by Luka Miljak on 08/06/14.
//  Copyright (c) 2014 Luka Miljak. All rights reserved.
//

#import "Body.h"

@interface Assembly : Body

@property (strong, nonatomic) NSMutableSet *bodies;
@property (nonatomic) CGPoint position;
@property (nonatomic) float angle;

- (instancetype)initWithBodies:(NSArray *)bodies;

- (void)drawInContext:(CGContextRef)context;
- (void)addBody:(Body *)body;
- (void)addBody:(Body *)body atAssemblyCoordinates:(CGPoint)coordinates;
- (void)removeBody:(Body *)body;

@end


