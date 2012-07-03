//
//  SGGSprite.m
//  SimpleOpenGLESDemo
//
//  Created by Arty on 7/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Sprite.h"
#import "GLKTextureLoader+Utils.h"

typedef struct {
    CGPoint geometryVertex;
    CGPoint textureVertex;
} TexturedVertex;

typedef struct {
    TexturedVertex bl;
    TexturedVertex br;    
    TexturedVertex tl;
    TexturedVertex tr;    
} TexturedQuad;

@interface Sprite()
@property (nonatomic, strong, readwrite) GLKBaseEffect *effect;
@property (nonatomic, strong) GLKTextureInfo *textureInfo;
@property (nonatomic, assign) TexturedQuad quad;

- (id)initWithTexture:(GLKTextureInfo *)texture effect:(GLKBaseEffect *)effect;
@end

@implementation Sprite
@synthesize effect, quad, textureInfo, position, contentSize,
    moveVelocity, rotation;

- (id)initWithTexture:(GLKTextureInfo *)texture effect:(GLKBaseEffect *)aEffect {
    self = [super init];
    if (self) {
        self.textureInfo = texture;
        self.effect = aEffect;
        self.contentSize = CGSizeMake(15.0f, 15.0f);
        
        TexturedQuad newQuad;
        newQuad.bl.geometryVertex = CGPointMake(0, 0);
        newQuad.br.geometryVertex = CGPointMake(self.textureInfo.width, 0);
        newQuad.tl.geometryVertex = CGPointMake(0, self.textureInfo.height);
        newQuad.tr.geometryVertex = CGPointMake(self.textureInfo.width, self.textureInfo.height);
        
        newQuad.bl.textureVertex = CGPointMake(0, 0);
        newQuad.br.textureVertex = CGPointMake(1, 0);
        newQuad.tl.textureVertex = CGPointMake(0, 1);
        newQuad.tr.textureVertex = CGPointMake(1, 1);
        self.quad = newQuad;
    }
    return self;
}

- (id)initWithFile:(NSString *)fileName effect:(GLKBaseEffect *)aEffect {
    self = [self initWithTexture:[GLKTextureLoader textureWithFile:fileName] effect:aEffect];
    return self;
}

- (GLKMatrix4)modelMatrix {
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, 0);
    modelMatrix = GLKMatrix4Translate(modelMatrix, - self.contentSize.width / 2, - self.contentSize.height / 2, 0);
    if (self.rotation != 0) {
        GLKVector2 adjustment = GLKVector2Make(self.contentSize.width * -0.5f,
                                               self.contentSize.height * -0.5f);
        GLKVector2 angleAdjustment;
        angleAdjustment.x = adjustment.x * cos(self.rotation) - adjustment.y * sin(self.rotation);
        angleAdjustment.y = adjustment.x * sin(self.rotation) + adjustment.y * cos(self.rotation);
        modelMatrix = GLKMatrix4Translate(modelMatrix,
                                          angleAdjustment.x + self.contentSize.width / 2,
                                          angleAdjustment.y + self.contentSize.height / 2, 0);
        modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotation, 0, 0, 1);
    }
    return modelMatrix; 
}

- (void)render { 
    self.effect.texture2d0.name = self.textureInfo.name;
    self.effect.texture2d0.enabled = YES;
    self.effect.transform.modelviewMatrix = self.modelMatrix;    
    [self.effect prepareToDraw];
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    long offset = (long)&quad;        
    glVertexAttribPointer(GLKVertexAttribPosition, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex),
                          (void *) (offset + offsetof(TexturedVertex, geometryVertex)));
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(TexturedVertex),
                          (void *) (offset + offsetof(TexturedVertex, textureVertex)));
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

- (void)update:(float)dt {
    GLKVector2 curMove = GLKVector2MultiplyScalar(self.moveVelocity, dt);
    self.position = GLKVector2Add(self.position, curMove);    
}

@end


@implementation Sprite (Text)

- (id)initWithString:(NSString *)text fontSize:(float)fontSize color:(UIColor *)textColor effect:(GLKBaseEffect *)aEffect {
    self = [self initWithTexture:[GLKTextureLoader textureWithString:text fontSize:fontSize color:textColor] effect:aEffect];
    return self;
}

@end
