//
//  SceneObject.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Renderable <NSObject>
- (void)render;

@optional
- (void)update:(float)delta;
@end
