//
//  Monster.h
//  Pacman
//
//  Created by Arty on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"

@interface Monster : Character

- (Monster *)initWithEffect:(GLKBaseEffect *)effect;

- (void)playerLocationChanged:(WorldCoord)coord;

@end
