//
//  FLAStarPathfinder.m
//  Pacman
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Pathfinder.h"

@implementation Pathfinder
@synthesize delegate;

- (id)initWithPathfinderDelegate:(id<PathfinderDelegate>)aDelegate {
    if (self = [super init]) {
        self.delegate = aDelegate;
    }
    return self;
}

- (NSArray*)findPathFromSource:(CGPoint)source toDestination:(CGPoint)destination {
    NSMutableSet *closedSet, *openSet;
    NSMutableDictionary *cameFrom;
    NSMutableDictionary *gScores, *hScores, *fScores;
    
    closedSet = [NSMutableSet set];
    openSet = [NSMutableSet setWithObject:[NSValue valueWithCGPoint:source]];
    cameFrom = [NSMutableDictionary dictionary];
    
    gScores = [NSMutableDictionary dictionary];
    hScores = [NSMutableDictionary dictionary];
    fScores = [NSMutableDictionary dictionary];
    
    NSNumber* gScoreStart = [NSNumber numberWithInt:0];
    NSNumber* hScoreStart = [NSNumber numberWithInt:[self heuristicCostEstimateFromSource:source toDestination:destination]];
    NSNumber* fScoreStart = [NSNumber numberWithInt:[gScoreStart integerValue] + [hScoreStart integerValue]];
    
    [gScores setObject:gScoreStart forKey:[NSValue valueWithCGPoint:source]];
    [hScores setObject:hScoreStart forKey:[NSValue valueWithCGPoint:source]];
    [fScores setObject:fScoreStart forKey:[NSValue valueWithCGPoint:source]];
    
    while ([openSet count]) {
        CGPoint current;
        NSInteger minimumFScore = NSIntegerMax;
        for (NSValue *currentValue in openSet) {
            NSInteger currentFScore = [[fScores objectForKey:currentValue] integerValue];
            minimumFScore = MIN(currentFScore, minimumFScore);
            if (minimumFScore == currentFScore)
                current = [currentValue CGPointValue];
        }
        
        if (CGPointEqualToPoint(current, destination)) {
            NSValue *currentValue = [NSValue valueWithCGPoint:current];
            NSMutableArray *returnValue = [NSMutableArray arrayWithObject:currentValue];
            while ((currentValue = [cameFrom objectForKey:currentValue]))
                [returnValue addObject:currentValue];
            NSMutableArray *returnValue2 = [NSMutableArray arrayWithCapacity:[returnValue count]];
            for (id item in [returnValue reverseObjectEnumerator])
                [returnValue2 addObject:item];
            return returnValue2;
        }
        
        [openSet removeObject:[NSValue valueWithCGPoint:current]];
        [closedSet addObject:[NSValue valueWithCGPoint:current]];
        
        for (NSValue* neighbour in [self neighbouringNodesForPoint:current]) {
            if ([closedSet containsObject:neighbour])
                continue;
            
            NSInteger tentativeGScore = [[gScores objectForKey:neighbour] integerValue]
                + [self distanceBetweenPointA:[neighbour CGPointValue] andPointB:destination];
            
            BOOL tentativeIsBetter = NO;
            
            if (![openSet containsObject:neighbour]) {
                [openSet addObject:neighbour];
                
                NSNumber* hScoreNeighbour = [NSNumber numberWithInteger:[self heuristicCostEstimateFromSource:current toDestination:[neighbour CGPointValue]]];
                
                [hScores setObject:hScoreNeighbour forKey:neighbour];
                
                tentativeIsBetter = YES;
            }
            else if (tentativeGScore < [[gScores objectForKey:neighbour] integerValue])
                tentativeIsBetter = YES;
            else
                tentativeIsBetter = NO;
            
            if (tentativeIsBetter) {
                [cameFrom setObject:[NSValue valueWithCGPoint:current] forKey:neighbour];
                [gScores setObject:[NSNumber numberWithInteger:tentativeGScore] forKey:neighbour];
                [fScores setObject:[NSNumber numberWithInteger:[[gScores objectForKey:neighbour] integerValue] + [[hScores objectForKey:neighbour] integerValue]] forKey:neighbour];
            }
        }
    }
    return nil;
}

- (NSInteger)heuristicCostEstimateFromSource:(CGPoint)source toDestination:(CGPoint)destination {
    return [self distanceBetweenPointA:source andPointB:destination];
}

- (NSSet *)neighbouringNodesForPoint:(CGPoint)point {
    NSMutableSet *returnSet = [NSMutableSet set];
    
    CGPoint neighbours[4] = {
        CGPointMake(point.x + 1, point.y),
        CGPointMake(point.x - 1, point.y),
        CGPointMake(point.x, point.y + 1),
        CGPointMake(point.x, point.y - 1)
    };
    
    for (int i = 0; i < 4; i++)
        if (![self.delegate isPointAnObstruction:neighbours[i]])
            [returnSet addObject:[NSValue valueWithCGPoint:neighbours[i]]];
    
    return returnSet;
}

- (NSInteger)distanceBetweenPointA:(CGPoint)a andPointB:(CGPoint)b {
    return abs(a.x - b.x) + abs(a.y - b.y);
}

@end