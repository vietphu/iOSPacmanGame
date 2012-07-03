//
//  PlayerStats.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Renderable.h"

@interface PlayerStats : NSObject<Renderable>
@property (nonatomic, assign, readonly) int totalScore;

- (id)initWithEffect:(GLKBaseEffect *)effect;
- (void)collectFood;
@end
