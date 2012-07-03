//
//  Animation.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Sprite.h"
#import "Renderable.h"

@interface Animation : NSObject<Renderable>
@property (nonatomic, assign) GLKVector2 position;
@property (nonatomic, assign) CGFloat rotation;

- (id)initWithFrames:(NSArray *)frames;

@end
