//
//  InGameSpriteManager.m
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//
//

#import "InGameSpriteManager.h"

@implementation InGameSpriteManager

@synthesize inGameLayer;

static InGameSpriteManager* _sharedInGameSpriteManager = nil;

-(id) init
{
    if ((self = [super init])) {
    }
    
    return self;
}

+(id)alloc
{
    @synchronized([InGameSpriteManager class]) {
        NSAssert(_sharedInGameSpriteManager == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedInGameSpriteManager = [super alloc];
        return _sharedInGameSpriteManager;
    }
    
    return nil;
}

+(InGameSpriteManager *)shared
{
    @synchronized([InGameSpriteManager class]) {
        if (!_sharedInGameSpriteManager)
            [[self alloc] init];
        return _sharedInGameSpriteManager;
    }
    
    return nil;
}

// This is never dealloc'd.
- (void) dealloc
{
	// don't forget to call "super dealloc"
	// [super dealloc];
}

-(void) loadInGameGraphics
{
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:kInGameGraphicsPlist];
    CCSpriteFrame *ss = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:kBlueBlock];
    inGameBatchNode = [CCSpriteBatchNode batchNodeWithTexture:ss.texture];
}

-(void) releaseInGameGraphics
{
  //  [inGameBatchNode release];
    inGameBatchNode = nil;
    [[CCSpriteFrameCache sharedSpriteFrameCache] removeSpriteFramesFromFile:kInGameGraphicsPlist];
}

-(void) attachInGameGraphics: (CCLayer *)layer
{
    if (inGameLayer)
        [self deattachInGameGraphics:inGameLayer];
    [layer addChild:inGameBatchNode];
    inGameLayer = layer;
}

-(void) deattachInGameGraphics: (CCLayer *)layer
{
    [layer removeChild:inGameBatchNode cleanup:FALSE];
    inGameLayer = nil;
}

-(CCSprite *) newInGameSprite: (NSString *)spriteFrameName
{
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:spriteFrameName];
    [inGameBatchNode addChild:sprite];
    return sprite;
}

-(void) removeInGameSprite: (CCSprite *)sprite
{
    [inGameBatchNode removeChild:sprite cleanup:true];
}

@end
