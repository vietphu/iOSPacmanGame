//
//  Scene.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Scene.h"
#import "SceneManager.h"

@interface Scene ()
@property (nonatomic, assign, readwrite) SceneManager *sceneManager;
@property (nonatomic, strong, readwrite) GLKBaseEffect *effect;
@property (nonatomic, strong, readwrite) NSMutableArray *childs;

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

- (void)installGestureRecognizers;
- (void)uninstallGestureRecognizers;

- (void)handleTap:(UITapGestureRecognizer *)recognizer;
@end

@implementation Scene
@synthesize sceneManager, effect, childs, tapRecognizer;

- (id)initWithSceneManager:(SceneManager *)manager {
    self = [super init];
    if (self) {
        self.sceneManager = manager;
        
        self.effect = [[GLKBaseEffect alloc] init];
        GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, 480, 0, 320, -1024, 1024);
        self.effect.transform.projectionMatrix = projectionMatrix;
        
        self.childs = [NSMutableArray arrayWithCapacity:10];

        [self installGestureRecognizers];
    }
    return self;
}

- (void)dealloc {
    [self uninstallGestureRecognizers];
}

- (void)render {
    for (id<Renderable> renderable in self.childs) {
        [renderable render];
    }
}

- (void)update:(float)delta {
}

- (void)installGestureRecognizers {
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                 action:@selector(handleTap:)];
    [self.sceneManager.view addGestureRecognizer:self.tapRecognizer];
}

- (void)uninstallGestureRecognizers {
    [self.sceneManager.view removeGestureRecognizer:self.tapRecognizer];
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self handleTapEvent];
}

- (void)handleTapEvent {
}

@end
