//
//  Animation.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Animation.h"

@interface Animation ()
@property (nonatomic, strong, readwrite) NSArray *frames;
@property (nonatomic, assign, readwrite) int currentFrameIndex;
@property (nonatomic, assign) float timeSinceLastFrame;
@end

@implementation Animation
@synthesize frames, position, currentFrameIndex, timeSinceLastFrame, rotation;

- (id)initWithFrames:(NSArray *)aFrames {
    self = [super init];
    if (self) {
        self.frames = aFrames;
    }
    return self;
}

- (void)render {
    Sprite *currentFrame = [self.frames objectAtIndex:self.currentFrameIndex];
    currentFrame.position = self.position;
    currentFrame.rotation = self.rotation;
    [currentFrame render];
}

- (void)update:(float)delta {
    self.timeSinceLastFrame += delta;
    if (self.timeSinceLastFrame > 0.05f) {
        self.timeSinceLastFrame = 0;
        
        self.currentFrameIndex = self.currentFrameIndex + 1;
        if (self.currentFrameIndex >= self.frames.count) {
            self.currentFrameIndex = 0;            
        }
    }    
}

@end
