//
//  GameSceneObject.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Renderable.h"

@class GameScene;

@interface GameSceneObject : NSObject<Renderable>
@property (nonatomic, assign) GameScene *gameScene;

@end
