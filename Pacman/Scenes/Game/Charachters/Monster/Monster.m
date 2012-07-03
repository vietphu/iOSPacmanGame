//
//  Monster.m
//  Pacman
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Monster.h"
#import "Sprite.h"

#import "GameScene.h"
#import "Pathfinder.h"

@interface Monster () <PathfinderDelegate>
@property (nonatomic, strong) Sprite *sprite;
@property (nonatomic, strong) Pathfinder *pathFinder;

@property (nonatomic, assign) WorldCoord playerLocation;
@end

@implementation Monster
@synthesize sprite, pathFinder, playerLocation;

- (Monster *)initWithEffect:(GLKBaseEffect *)effect {
    self = [super initWithEffect:effect];
    if (self) {
        self.sprite = [[Sprite alloc] initWithFile:@"soul-1.png" effect:effect];
        self.pathFinder = [[Pathfinder alloc] initWithPathfinderDelegate:self];
    }
    return self;
}

- (void)setPosition:(GLKVector2)position {
    self.sprite.position = position;
}

- (GLKVector2)position {
    return self.sprite.position;
}

- (float)moveSpeed {
    return 2.0f;
}

- (void)update:(CGFloat)delta {
    [super update:delta];
    
    [self.sprite update:delta];
}

- (void)render {
    [super render];
    [self.sprite render];
}

- (WorldCoord)nextWorldCoordForMovingWithDirection:(CharacterMoveDirection)direction {
    NSArray *path = [self.pathFinder findPathFromSource:CGPointMake(self.worldCoords.i, self.worldCoords.j)
                                          toDestination:CGPointMake(self.playerLocation.i, self.playerLocation.j)];
    BOOL hasPath = (path.count >= 2);
    if (hasPath) {
        CGPoint target = [[path objectAtIndex:1] CGPointValue];
        return WorldCoordMake(target.x, target.y);
    } else {
        return self.worldCoords;
    }
}

- (BOOL)isPointAnObstruction:(CGPoint)point {
    return ![self.gameScene canCharacter:self movePlayerToWorldCoord:WorldCoordMake(point.x, point.y)];
}

- (void)playerLocationChanged:(WorldCoord)coord {
    self.playerLocation = coord;
}

@end
