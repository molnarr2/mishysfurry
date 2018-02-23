//
//  Spike.m
//  MishyFurry
//
//  Created by Robert Molnar 2 on 10/14/13.
//
//

#import "Spike.h"

@implementation Spike

@synthesize life;
@synthesize screenPosition;

-(id) initTheSpike:(int)_life screenPosition:(CGPoint)_screenPosition
{
    if ((self=[super init])) {
        life = _life;
        screenPosition = _screenPosition;
        sprite = [[InGameSpriteManager shared] newInGameSprite:kSpike];
        [sprite setPosition:screenPosition];
    }
    return self;
}

-(bool)decrementLife
{
    life--;
    if (life == 0) {
        [[InGameSpriteManager shared] removeInGameSprite:sprite];
        sprite = nil;
    }
    
    if (life >= 0)
        return true;
    return false;
}

-(void)lightningStrikes
{
    // Generate the lightning.
    for (int i=0; i < 6; i++) {
        lightning[i] = [[InGameSpriteManager shared] newInGameSprite:kLightening];
        CGPoint pt = CGPointMake((i+1) * kGameBlockSize, screenPosition.y);
        [lightning[i] setPosition:pt];
    }
    
    // Wait for 0.5 seconds for the lightning.
    id delayTime1 = [CCDelayTime actionWithDuration:0.5f];
    CCCallFunc* func = [CCCallFunc actionWithTarget:self selector:@selector(lightningFinished)];
    CCSequence *seq = [CCSequence actions: delayTime1, func, nil];
    [lightning[0] runAction:seq];
}

-(void)lightningFinished
{
    for (int i=0; i < 6; i++) {
        if (lightning[i])
            [[InGameSpriteManager shared] removeInGameSprite:lightning[i]];
        lightning[i] = nil;
    }
}

-(void) dealloc
{
    [[InGameSpriteManager shared] removeInGameSprite:sprite];
    sprite = nil;
}
@end
