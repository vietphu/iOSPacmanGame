//
//  SceneManager.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SceneManager.h"

#import "Scene.h"

#import "GameScene.h"
#import "MainMenuScene.h"

#import "GameWinScene.h"
#import "GameOverScene.h"

@interface SceneManager ()
@property (nonatomic, assign, readwrite) UIView *view;
@property (nonatomic, strong) Scene *currentScene;
@end

@implementation SceneManager
@synthesize view, currentScene;

- (id)initWithView:(UIView *)aView {
    self = [super init];
    if (self) {
        self.view = aView;
        
        [self setCurrentSceneWithType:SceneTypeMainMenu];
    }
    return self;
}

- (void)render {
    [self.currentScene render];
}

- (void)update:(float)delta {
    [self.currentScene update:delta];
}

- (void)setCurrentSceneWithType:(SceneType)type {
    Scene *scene = nil;
    switch (type) {
        case SceneTypeMainMenu:
            scene = [[MainMenuScene alloc] initWithSceneManager:self];
            break;
        case SceneTypeGame:
            scene = [[GameScene alloc] initWithSceneManager:self];            
            break;
        case SceneTypeGameWin:
            scene = [[GameWinScene alloc] initWithSceneManager:self];            
            break;
        case SceneTypeGameOver:
            scene = [[GameOverScene alloc] initWithSceneManager:self];            
            break;
    }
    self.currentScene = scene;
}

@end
