//
//  World.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "World.h"
#import "Sprite.h"

#import "GameScene.h"

WorldCoord
WorldCoordMake(int i, int j) {
    WorldCoord result;
    result.i = i;
    result.j = j;
    return result;
}

BOOL isWorldCoordEquals(WorldCoord i, WorldCoord j) {
    return (i.i == j.i) && (i.j == j.j);
}

GLKVector2 WorldCoords2GL(int i, int j) {
    return GLKVector2Make(80.0f + j * 15.0f, 302.0f - i * 15.0f);    
}

GLKVector2 WorldCoords2GL2(WorldCoord coord) {
    return GLKVector2Make(80.0f + coord.j * 15.0f, 302.0f - coord.i * 15.0f);        
}

static int WorldCellsPrototype[WORLD_SIZE][WORLD_SIZE] = {
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
    {0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0},
    {0, 1, 2, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 2, 1, 0},
    {0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0},
    {0, 1, 2, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 2, 1, 0},
    {0, 1, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 2, 1, 0},
    {0, 1, 1, 1, 1, 2, 1, 1, 1, 0, 1, 0, 1, 1, 1, 2, 1, 1, 1, 1, 0},
    {0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0}, 
    {1, 1, 1, 1, 1, 2, 1, 0, 1, 1, 0, 1, 1, 0, 1, 2, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0},
    {1, 1, 1, 1, 1, 2, 1, 0, 1, 1, 1, 1, 1, 0, 1, 2, 1, 1, 1, 1, 1},
    {0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0, 0, 0, 0, 1, 2, 1, 0, 0, 0, 0},
    {0, 1, 1, 1, 1, 2, 1, 0, 1, 1, 1, 1, 1, 0, 1, 2, 1, 1, 1, 1, 0},
    {0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0},
    {0, 1, 2, 1, 1, 2, 1, 1, 1, 2, 1, 2, 1, 1, 1, 2, 1, 1, 2, 1, 0},
    {0, 1, 2, 2, 1, 2, 2, 2, 2, 2, 0, 2, 2, 2, 1, 2, 1, 2, 2, 1, 0},
    {0, 1, 1, 2, 1, 2, 1, 2, 1, 1, 1, 1, 1, 2, 1, 2, 1, 2, 1, 1, 0},
    {0, 1, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 2, 2, 1, 0},
    {0, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 0},
    {0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0},
    {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0}
};

@interface World () {
    int WorldCells[WORLD_SIZE][WORLD_SIZE];
}
@property (nonatomic, strong) NSDictionary *tiles;
@property (nonatomic, assign) int foodCount;
@end

@implementation World
@synthesize tiles, foodCount;

- (id)initWithEffect:(GLKBaseEffect *)effect {
    self = [super init];
    if (self) {
        self.tiles = [NSDictionary dictionaryWithObjectsAndKeys:
                             [[Sprite alloc] initWithFile:@"empty.png" effect:effect],
                             [NSNumber numberWithInt:WorldCellEmpty],
                             [[Sprite alloc] initWithFile:@"wall.png" effect:effect],
                             [NSNumber numberWithInt:WorldCellWall],
                             [[Sprite alloc] initWithFile:@"empty_with_food.png" effect:effect],
                             [NSNumber numberWithInt:WorldCellEmptyWithFood],
                             nil];
        memcpy(WorldCells, WorldCellsPrototype, sizeof(WorldCells));
        self.foodCount = WORLD_FOOD_COUNT;
    }
    return self;
}

- (void)render {
    for (int i = 0; i < WORLD_SIZE; i++) {
        for (int j = 0; j < WORLD_SIZE; j++) {
            Sprite *tile = [self.tiles objectForKey:
                            [NSNumber numberWithInt:WorldCells[i][j]]];
            tile.position = WorldCoords2GL(i, j);
            [tile render];
        }
    }
}

- (WorldCell)worldCellWithCoord:(WorldCoord)coord {
    return WorldCells[coord.i][coord.j];
}

- (BOOL)isEmptyCellWithCoord:(WorldCoord)coord {
    WorldCell cell = WorldCells[coord.i][coord.j];
    return ((cell == WorldCellEmpty) || (cell == WorldCellEmptyWithFood));
}

- (BOOL)eatFoodInCellWithCoord:(WorldCoord)coord {
    WorldCell cell = WorldCells[coord.i][coord.j];
    if (cell == WorldCellEmptyWithFood) {
        WorldCells[coord.i][coord.j] = WorldCellEmpty;
        self.foodCount = self.foodCount - 1;
        return YES;
    }
    return NO;
}

- (void)setFoodCount:(int)value {
    foodCount = value;
    
    if (foodCount == 0) {
        [self.gameScene allFoodCollectedByPlayer];
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"Food count: %d", self.foodCount];
}

@end
