//
//  ResultsScene.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GameWinScene.h"
#import "SceneManager.h"
#import "Sprite.h"

@implementation GameWinScene

- (id)initWithSceneManager:(SceneManager *)manager {
    self = [super initWithSceneManager:manager];
    if (self) {
        Sprite *victoryLabel = [[Sprite alloc] initWithString:@"Happy End"
                                                     fontSize:40.0f
                                                        color:[UIColor whiteColor]
                                                       effect:self.effect];
        victoryLabel.position = GLKVector2Make(140.0f, 170.0f);
        [self.childs addObject:victoryLabel];
        
        Sprite *touchLabel = [[Sprite alloc] initWithString:@"Touch to continue..."
                                                   fontSize:16.0f
                                                      color:[UIColor whiteColor]
                                                     effect:self.effect];
        touchLabel.position = GLKVector2Make(170.0f, 50.0f);
        [self.childs addObject:touchLabel];
    }
    return self;
}

- (void)handleTapEvent {
    [self.sceneManager setCurrentSceneWithType:SceneTypeMainMenu];    
}

@end

