//
//  PlayerJoystick.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerJoystick.h"
#import "Player.h"

@interface PlayerJoystick ()
@property (nonatomic, assign) UIView *view;
@property (nonatomic, assign) Player *player;

@property (nonatomic, strong) UISwipeGestureRecognizer *upRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *downRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *leftRecognizer;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightRecognizer;

- (void)installGestureRecognizers;
- (void)uninstallGestureRecognizers;

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)recognizer;
- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer;
- (void)handleSwipeTop:(UISwipeGestureRecognizer *)recognizer;
- (void)handleSwipeBottom:(UISwipeGestureRecognizer *)recognizer;
@end

@implementation PlayerJoystick
@synthesize view, player, upRecognizer, downRecognizer, leftRecognizer, rightRecognizer;

- (id)initWithView:(UIView *)aView player:(Player *)aPlayer {
    self = [super init];
    if (self) {
        self.view = aView;
        self.player = aPlayer;
        
        [self installGestureRecognizers];
    }
    return self;
}

- (void)dealloc {
    [self uninstallGestureRecognizers];
}

- (void)installGestureRecognizers {
    self.rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(handleSwipeRight:)];
    self.rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightRecognizer];
    
    self.leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handleSwipeLeft:)];
    self.leftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.leftRecognizer];
    
    self.upRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                  action:@selector(handleSwipeTop:)];
    self.upRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:self.upRecognizer];
    
    self.downRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                    action:@selector(handleSwipeBottom:)];
    self.downRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:self.downRecognizer];
}

- (void)uninstallGestureRecognizers {
    [self.view removeGestureRecognizer:self.upRecognizer];
    [self.view removeGestureRecognizer:self.downRecognizer];
    [self.view removeGestureRecognizer:self.leftRecognizer];
    [self.view removeGestureRecognizer:self.rightRecognizer];    
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)recognizer {
    self.player.moveDirection = CharacterMoveDirectionRight;
}

- (void)handleSwipeLeft:(UISwipeGestureRecognizer *)recognizer {
    self.player.moveDirection = CharacterMoveDirectionLeft;
}

- (void)handleSwipeTop:(UISwipeGestureRecognizer *)recognizer {
    self.player.moveDirection = CharacterMoveDirectionUp;
}

- (void)handleSwipeBottom:(UISwipeGestureRecognizer *)recognizer {
    self.player.moveDirection = CharacterMoveDirectionDown;
}

@end
