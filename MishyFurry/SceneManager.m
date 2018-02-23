//
//  SceneManager.m
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/22/12.
//
//

#import "SceneManager.h"

@implementation SceneManager

static SceneManager* _sharedSceneManager = nil;


-(id) init
{
    if ((self = [super init])) {
    }
    
    return self;
}

+(id)alloc
{
    @synchronized([SceneManager class]) {
        NSAssert(_sharedSceneManager == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedSceneManager = [super alloc];
        return _sharedSceneManager;
    }
    
    return nil;
}

+(SceneManager *)shared
{
    @synchronized([SceneManager class]) {
        if (!_sharedSceneManager)
            [[self alloc] init];
        return _sharedSceneManager;
    }
    return nil;
}

-(void)startMainMenu:(bool) bReplaceScene
{
    CCScene* mainMenuScene = [CCBReader sceneWithNodeGraphFromFile:@"MainMenuScene.ccbi"];

    if (bReplaceScene) {
        [[CCDirector sharedDirector] replaceScene: mainMenuScene];
    } else {
        [[CCDirector sharedDirector] pushScene: mainMenuScene];
    }
}

-(void)startNewArcadeGame
{
    gameType = arcadeGame;
    [[CCDirector sharedDirector] replaceScene: [InGameMainLayer sceneArcade]];
}

-(void)startNewInsaneGame
{
    gameType = insaneGame;
    [[CCDirector sharedDirector] replaceScene: [InGameMainLayer sceneInsane]];
}

-(void)startNewFrenzyGame
{
    gameType = frenzyGame;
    [[CCDirector sharedDirector] replaceScene: [InGameMainLayer sceneFrenzy]];
}

-(void)startNewGame
{
    if (gameType == arcadeGame)
        [self startNewArcadeGame];
    else if (gameType == insaneGame)
        [self startNewInsaneGame];
    else
        [self startNewFrenzyGame];
}

@end
