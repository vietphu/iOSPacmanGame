//
//  Player.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "GameScene.h"

BOOL isOppositeDirections(CharacterMoveDirection directionA, CharacterMoveDirection directionB) {
    int sum = directionA + directionB;
    return ((sum == 2) || (sum == 12));
}

@interface Character ()
@property (nonatomic, assign) float timeSinceLastFrame;

- (void)move;
- (void)nextMoveWithDirection:(CharacterMoveDirection)direction;
- (void)keepMoving;
@end

@implementation Character
@synthesize moveDirection, timeSinceLastFrame;

- (Character *)initWithEffect:(GLKBaseEffect *)effect {
    self = [super init];
    if (self) {
        self.moveDirection = CharacterMoveDirectionRight;
    }
    return self;
}

- (void)updateAnimationWithDirection:(CharacterMoveDirection)direction {
}

- (void)setMoveDirection:(CharacterMoveDirection)value {
    BOOL isOpposite = isOppositeDirections(moveDirection, value);
    if (isOpposite) {
        [self nextMoveWithDirection:value];
        moveDirection = value;
    } else {
        int nextI = self.worldCoords.i;
        int nextJ = self.worldCoords.j;
        switch (value) {
            case CharacterMoveDirectionDown:
                nextI++;
                break;
            case CharacterMoveDirectionRight:
                nextJ++;
                break;
            case CharacterMoveDirectionUp:
                nextI--;
                break;
            case CharacterMoveDirectionLeft:
                nextJ--;
                break;
        }
        WorldCoord nextWorldCoord = WorldCoordMake(nextI, nextJ);
        if ([self.gameScene canCharacter:self movePlayerToWorldCoord:nextWorldCoord]) {
            moveDirection = value;            
        }
    }
}

- (void)setPosition:(GLKVector2)position {
}

- (GLKVector2)position {
    return GLKVector2Make(0, 0);
}

- (void)render {
}

- (void)update:(CGFloat)delta {
    self.timeSinceLastFrame += delta;
    if (self.timeSinceLastFrame > 0.02f) {
        self.timeSinceLastFrame = 0.0f;
        [self move];
    }
}

- (float)moveSpeed {
    return 0.0f;
}

- (void)move {
    BOOL playerInTargetCoords = GLKVector2Distance(self.position, WorldCoords2GL2(self.worldCoords)) == 0.0f;
    if (playerInTargetCoords) {
        [self.gameScene character:self movedToWorldCoord:self.worldCoords];
        [self nextMoveWithDirection:self.moveDirection];
    } else {
        [self keepMoving];
    }
}

- (WorldCoord)nextWorldCoordForMovingWithDirection:(CharacterMoveDirection)direction {
    int nextI = self.worldCoords.i;
    int nextJ = self.worldCoords.j;
    switch (direction) {
        case CharacterMoveDirectionDown:
            nextI++;
            break;
        case CharacterMoveDirectionRight:
            nextJ++;
            break;
        case CharacterMoveDirectionUp:
            nextI--;
            break;
        case CharacterMoveDirectionLeft:
            nextJ--;
            break;
    }
    return WorldCoordMake(nextI, nextJ);
}

- (void)nextMoveWithDirection:(CharacterMoveDirection)direction {
    WorldCoord nextWorldCoord = [self nextWorldCoordForMovingWithDirection:direction];
    if ([self.gameScene canCharacter:self movePlayerToWorldCoord:nextWorldCoord]) {
        self.worldCoords = nextWorldCoord;
        [self updateAnimationWithDirection:direction];
    }
}

- (void)keepMoving {
    GLKVector2 target = WorldCoords2GL2(self.worldCoords);
    float stepX = 0.0f;
    float deltaX = target.x - self.position.x;
    if (deltaX != 0.0f)  {
        stepX = round(deltaX / fabs(deltaX)) * self.moveSpeed;
        if (fabs(deltaX) < fabs(stepX)) {
            stepX = deltaX;
        }
    }
    float stepY = 0.0f;    
    float deltaY = target.y - self.position.y;
    if (deltaY != 0.0f) {
        stepY = round(deltaY / fabs(deltaY)) * self.moveSpeed;
        if (fabs(deltaY) < fabs(stepY)) {
            stepY = deltaY;
        }
    }
    
    self.position = GLKVector2Make(self.position.x + stepX, self.position.y + stepY);
}

@end
