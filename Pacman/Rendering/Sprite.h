//
//  SGGSprite.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Renderable.h"

@interface Sprite : NSObject<Renderable>
@property (nonatomic, strong, readonly) GLKBaseEffect *effect;
@property (assign) CGSize contentSize;

@property (assign) GLKVector2 position;
@property (assign) GLKVector2 moveVelocity;

@property (nonatomic, assign) CGFloat rotation;

- (id)initWithFile:(NSString *)fileName effect:(GLKBaseEffect *)effect;

@end

@interface Sprite (Text)
- (id)initWithString:(NSString *)text fontSize:(float)fontSize color:(UIColor *)textColor effect:(GLKBaseEffect *)effect;
@end
