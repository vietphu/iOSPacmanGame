//
//  FLAStarPathfinder.h
//  Pacman
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PathfinderDelegate <NSObject>
- (BOOL)isPointAnObstruction:(CGPoint)point;
@end

@interface Pathfinder : NSObject
@property (nonatomic, assign) id<PathfinderDelegate> delegate;

- (id)initWithPathfinderDelegate:(id<PathfinderDelegate>)delegate;

- (NSArray*)findPathFromSource:(CGPoint)source toDestination:(CGPoint)destination;

- (NSInteger)heuristicCostEstimateFromSource:(CGPoint)source toDestination:(CGPoint)destination;
- (NSSet*)neighbouringNodesForPoint:(CGPoint)point;
- (NSInteger)distanceBetweenPointA:(CGPoint)a andPointB:(CGPoint)b;

@end
