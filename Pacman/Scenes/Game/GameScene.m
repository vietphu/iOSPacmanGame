//
//  Map.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "SceneManager.h"

#import "Sprite.h"
#import "Animation.h"

#import "World.h"
#import "WorldObject.h"

#import "Character.h"

#import "Player.h"
#import "PlayerJoystick.h"

#import "Monster.h"

@interface GameScene ()
@property (nonatomic, strong) World *world;

@property (nonatomic, strong) Player *player;
@property (nonatomic, strong) PlayerJoystick *playerJoystick;

@property (nonatomic, strong) Monster *monster;
@end

@implementation GameScene
@synthesize world, player, playerJoystick, monster;

- (id)initWithSceneManager:(SceneManager *)manager {
    self = [super initWithSceneManager:manager ];
    if (self) {
        self.world = [[World alloc] initWithEffect:self.effect];
        self.world.gameScene = self;
        
        self.player = [[Player alloc] initWithEffect:self.effect];
        self.player.gameScene = self;
        
        self.player.worldCoords = WorldCoordMake(15, 10);
        self.player.position = WorldCoords2GL(15, 10);
        
        self.playerJoystick = [[PlayerJoystick alloc] initWithView:self.sceneManager.view
                                                            player:self.player];
        
        self.monster = [[Monster alloc] initWithEffect:self.effect];
        self.monster.gameScene = self;
        self.monster.worldCoords = WorldCoordMake(3, 10);
        self.monster.position = WorldCoords2GL(3, 10);
    }
    return self;
}

- (void)render {
    [self.world render];
    [self.player render];
    [self.monster render];
}

- (void)update:(float)delta {
    [self.player update:delta];
    [self.monster update:delta];
}

- (BOOL)canCharacter:(Character *)character movePlayerToWorldCoord:(WorldCoord)coord {
    return [self.world isEmptyCellWithCoord:coord];
}

- (void)character:(Character *)character movedToWorldCoord:(WorldCoord)coord {
    if ([character isKindOfClass:[Player class]]) {
        if ([self.world eatFoodInCellWithCoord:coord]) {
            [self.player collectFood];
        }
        [self.monster playerLocationChanged:self.player.worldCoords];
    } else {
        if (isWorldCoordEquals(character.worldCoords, self.player.worldCoords)) {
            [self.sceneManager setCurrentSceneWithType:SceneTypeGameOver];
        }
    }
}

- (void)allFoodCollectedByPlayer {
    [self.sceneManager setCurrentSceneWithType:SceneTypeGameWin];
}

@end
