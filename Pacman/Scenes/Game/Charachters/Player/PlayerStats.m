//
//  PlayerStats.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerStats.h"
#import "Sprite.h"

@interface PlayerStats ()
@property (nonatomic, assign, readwrite) int foodCollected;

@property (nonatomic, assign) GLKBaseEffect *effect;
@property (nonatomic, strong) Sprite *scoreLabel;

- (void)updateView;
@end

@implementation PlayerStats
@synthesize foodCollected, effect, scoreLabel;

- (id)initWithEffect:(GLKBaseEffect *)aEffect {
    self = [super init];
    if (self) {
        self.effect = aEffect;
        [self updateView];
    }
    return self;
}

- (void)collectFood {
    self.foodCollected = self.foodCollected + 1;
    [self updateView];
}

- (int)totalScore {
    return self.foodCollected * 5;
}

- (void)updateView {
    NSString *text = [NSString stringWithFormat:@"Score: %d", self.totalScore];
    self.scoreLabel = [[Sprite alloc] initWithString:text
                                            fontSize:16.0f
                                               color:[UIColor whiteColor] 
                                              effect:self.effect];
    self.scoreLabel.position = GLKVector2Make(10.0f, 290.0f);
}

- (void)render {
    [self.scoreLabel render];
}

@end
