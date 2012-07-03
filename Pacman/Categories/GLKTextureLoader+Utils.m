//
//  GLKTextureLoader+Text.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GLKTextureLoader+Utils.h"

@implementation GLKTextureLoader (Utils)

+ (GLKTextureInfo *)textureWithFile:(NSString *)fileName {
    NSDictionary * options = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithBool:YES],
                              GLKTextureLoaderOriginBottomLeft, 
                              nil];
    NSError * error;    
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    GLKTextureInfo *textureInfo = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (textureInfo == nil) {
        NSLog(@"Error loading file: %@", [error localizedDescription]);
    }
    return textureInfo;
}

+ (GLKTextureInfo *)textureWithString:(NSString *)string fontSize:(float)fontSize color:(UIColor *)textColor {
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontSize];
    CGSize size = [string sizeWithFont:font forWidth:500 lineBreakMode:UILineBreakModeClip];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    label.backgroundColor = [UIColor clearColor];
    label.text = string;
    label.textColor = textColor;
    label.font = font;
    
    UIGraphicsBeginImageContext(label.frame.size);
    [[label layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *layerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSError *error;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], GLKTextureLoaderOriginBottomLeft, nil];
    GLKTextureInfo *textureInfo = [self textureWithCGImage:layerImage.CGImage options:options error:&error];
    if (textureInfo == nil) {
        NSLog(@"[SF] Texture Error:%@", error);
    }
    return textureInfo;
}

@end
