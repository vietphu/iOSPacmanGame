//
//  Map.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "World.h"
#import "Scene.h"

@class Character;
@interface GameScene : Scene

- (BOOL)canCharacter:(Character *)character movePlayerToWorldCoord:(WorldCoord)coord;
- (void)character:(Character *)character movedToWorldCoord:(WorldCoord)coord;

- (void)allFoodCollectedByPlayer;
@end
