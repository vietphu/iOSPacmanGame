//
//  MainMenuScene.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "SceneManager.h"
#import "Sprite.h"

@implementation MainMenuScene

- (id)initWithSceneManager:(SceneManager *)manager {
    self = [super initWithSceneManager:manager];
    if (self) {
        Sprite *touchLabel = [[Sprite alloc] initWithString:@"Touch to play..."
                                                   fontSize:20.0f
                                                      color:[UIColor whiteColor]
                                                     effect:self.effect];
        touchLabel.position = GLKVector2Make(170.0f, 160.0f);
        [self.childs addObject:touchLabel];
    }
    return self;
}

- (void)handleTapEvent {
    [self.sceneManager setCurrentSceneWithType:SceneTypeGame];
}

@end
