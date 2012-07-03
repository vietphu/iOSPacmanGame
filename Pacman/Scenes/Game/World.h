//
//  World.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameSceneObject.h"

#define WORLD_SIZE 21
#define WORLD_FOOD_COUNT 149

typedef struct {
    int i;
    int j;
} WorldCoord;

typedef enum {
    WorldCellEmpty = 0,
    WorldCellWall = 1,
    WorldCellEmptyWithFood = 2
} WorldCell;

WorldCoord WorldCoordMake(int i, int j);
BOOL isWorldCoordEquals(WorldCoord i, WorldCoord j);

GLKVector2 WorldCoords2GL(int i, int j);
GLKVector2 WorldCoords2GL2(WorldCoord coord);

@interface World : GameSceneObject

- (id)initWithEffect:(GLKBaseEffect *)effect;

- (WorldCell)worldCellWithCoord:(WorldCoord)coord;

- (BOOL)isEmptyCellWithCoord:(WorldCoord)coord;
- (BOOL)eatFoodInCellWithCoord:(WorldCoord)coord;

@end
