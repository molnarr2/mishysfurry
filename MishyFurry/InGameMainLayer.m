//
//  InGameMainLayer.m
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "InGameMainLayer.h"

#pragma mark - InGameMainLayer

@implementation InGameMainLayer


+(CCScene *) sceneArcade
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	InGameMainLayer *layer = [InGameMainLayer node];
    [layer doArcadeGame];
	
	// add layer as a child to scene
	[scene addChild: layer z:-1 tag:52000];
    
	// return the scene
	return scene;
}

+(CCScene *) sceneFrenzy
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	InGameMainLayer *layer = [InGameMainLayer node];
    [layer doFrenzyGame];
	
	// add layer as a child to scene
	[scene addChild: layer z:-1 tag:52000];
    
	// return the scene
	return scene;
}

+(CCScene *) sceneInsane
{
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	InGameMainLayer *layer = [InGameMainLayer node];
    [layer doInsaneGame];
	
	// add layer as a child to scene
	[scene addChild: layer z:-1 tag:52000];
    
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        
        // Attach sprites to layer.
        [[InGameSpriteManager shared] attachInGameGraphics:self];
        
        inGameEngine = [[InGameEngine alloc] init];
        
        // Enable touch.
        self.isTouchEnabled = YES;
        
        [self scheduleUpdate];
	}
	return self;
}

-(void) doInsaneGame
{
    [inGameEngine doInsaneGame];

}

-(void) doFrenzyGame
{
    [inGameEngine doFrenzyGame];
}

-(void) doArcadeGame
{
    [inGameEngine doArcadeGame];
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        location.y = kDeviceHeight - location.y;
        [inGameEngine touchAt:location];
    }
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    
    [inGameEngine gameCleanup];
    inGameEngine = nil;
    
	// don't forget to call "super dealloc"
//	[super dealloc];
}

-(void) update:(ccTime)delta
{
    [inGameEngine update];
}


@end
