//
//  Spike.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 10/14/13.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "InGameSpriteManager.h"

@interface Spike : NSObject {
    // The absolute position of the spike on the screen.
    CGPoint screenPosition;
    CCSprite *sprite;
    CCSprite *lightning[6];
    
    // How many hit points it has.
    int life;
}

@property(assign) int life;
@property(assign) CGPoint screenPosition;

-(id) initTheSpike:(int)_life screenPosition:(CGPoint)_screenPosition;

// Decrement the life.
// @return true if lightening should happen.
-(bool)decrementLife;

// Perform lightning strike animation.
-(void)lightningStrikes;

// This is called once the lightning animation is finished.
-(void)lightningFinished;

@end
