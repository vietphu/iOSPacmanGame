//
//  GLKTextureLoader+Text.h
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GLKit/GLKit.h>

@interface GLKTextureLoader (Utils)

+ (GLKTextureInfo *)textureWithFile:(NSString *)fileName;
+ (GLKTextureInfo *)textureWithString:(NSString *)string
                             fontSize:(float)fontSize
                                color:(UIColor *)textColor;

@end
