//
//  PlayerJoystick.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Player;
@interface PlayerJoystick : NSObject

- (id)initWithView:(UIView *)view player:(Player *)player;

@end
