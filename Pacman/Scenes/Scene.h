//
//  Scene.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Renderable.h"

@class SceneManager;

typedef void (^CallbackBlock)(void);

@interface Scene : NSObject<Renderable>
@property (nonatomic, assign, readonly) SceneManager *sceneManager;
@property (nonatomic, strong, readonly) GLKBaseEffect *effect;
@property (nonatomic, strong, readonly) NSMutableArray *childs;

- (id)initWithSceneManager:(SceneManager *)manager;

- (void)handleTapEvent;

@end
