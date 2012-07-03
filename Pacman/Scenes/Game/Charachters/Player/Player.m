//
//  Player.m
//  Pacman
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "PlayerStats.h"

@interface Player ()
@property (nonatomic, strong) Animation *animation;
@property (nonatomic, strong) PlayerStats *stats;
@end

@implementation Player
@synthesize stats, animation;

- (Character *)initWithEffect:(GLKBaseEffect *)effect {
    self = [super initWithEffect:effect];
    if (self) {
        self.stats = [[PlayerStats alloc] initWithEffect:effect];
        self.animation = [[Animation alloc] initWithFrames:
                          [NSArray arrayWithObjects:
                           [[Sprite alloc] initWithFile:@"pacman-0.png" effect:effect],
                           [[Sprite alloc] initWithFile:@"pacman-1.png" effect:effect],
                           [[Sprite alloc] initWithFile:@"pacman-2.png" effect:effect],
                           [[Sprite alloc] initWithFile:@"pacman-3.png" effect:effect],
                           [[Sprite alloc] initWithFile:@"pacman-4.png" effect:effect],
                           [[Sprite alloc] initWithFile:@"pacman-5.png" effect:effect],
                           [[Sprite alloc] initWithFile:@"pacman-4.png" effect:effect],
                           [[Sprite alloc] initWithFile:@"pacman-3.png" effect:effect],
                           [[Sprite alloc] initWithFile:@"pacman-2.png" effect:effect],
                           [[Sprite alloc] initWithFile:@"pacman-1.png" effect:effect],
                           nil]];
    }
    return self;
}

- (float)moveSpeed {
    return 3.0f;
}

- (void)updateAnimationWithDirection:(CharacterMoveDirection)direction {
    switch (direction) {
        case CharacterMoveDirectionDown:
            self.animation.rotation = - M_PI_2;
            break;
        case CharacterMoveDirectionRight:
            self.animation.rotation = M_PI * 2;            
            break;
        case CharacterMoveDirectionUp:
            self.animation.rotation = M_PI_2;            
            break;
        case CharacterMoveDirectionLeft:
            self.animation.rotation = M_PI;            
            break;
    }
}

- (void)setPosition:(GLKVector2)position {
    self.animation.position = position;
}

- (GLKVector2)position {
    return self.animation.position;
}

- (void)update:(CGFloat)delta {
    [super update:delta];
    
    [self.animation update:delta];
}

- (void)render {
    [super render];
    
    [self.animation render];
    [self.stats render];
}

- (void)collectFood {
    [self.stats collectFood];
}

@end
