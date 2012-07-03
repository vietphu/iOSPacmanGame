//
//  Player.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Animation.h"
#import "WorldObject.h"

typedef enum {
    CharacterMoveDirectionLeft = 0,
    CharacterMoveDirectionRight = 2,
    CharacterMoveDirectionUp = 4, 
    CharacterMoveDirectionDown = 8
} CharacterMoveDirection;

BOOL isOppositeDirections(CharacterMoveDirection directionA, CharacterMoveDirection directionB);

@interface Character : WorldObject
@property (nonatomic, assign) CharacterMoveDirection moveDirection;

- (Character *)initWithEffect:(GLKBaseEffect *)effect;
- (void)setMoveDirection:(CharacterMoveDirection)moveDirection;

- (void)updateAnimationWithDirection:(CharacterMoveDirection)direction;

- (void)setPosition:(GLKVector2)position;
- (GLKVector2)position;

- (WorldCoord)nextWorldCoordForMovingWithDirection:(CharacterMoveDirection)direction;
- (float)moveSpeed;

@end
