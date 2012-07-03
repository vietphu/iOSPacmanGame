//
//  SceneManager.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Renderable.h"

typedef enum {
    SceneTypeMainMenu = 0,
    SceneTypeGame,
    SceneTypeGameWin,
    SceneTypeGameOver,
} SceneType;

@class Scene;

@interface SceneManager : NSObject<Renderable>
@property (nonatomic, assign, readonly) UIView *view;

- (id)initWithView:(UIView *)view;
- (void)setCurrentSceneWithType:(SceneType)type;

@end
