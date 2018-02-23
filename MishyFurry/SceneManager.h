//
//  SceneManager.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/22/12.
//
//

#import <Foundation/Foundation.h>
#import "CCBReader.h"
#import "InGameMainLayer.h"

enum GameType {
    arcadeGame,
    insaneGame,
    frenzyGame,
};

@interface SceneManager : NSObject {
    enum GameType gameType;
}

+(SceneManager *)shared;

// @param bReplaceScene true if the scene should be replaced, else it will be pushed.
-(void)startMainMenu:(bool) bReplaceScene;

// Scene will be replaced with a new game.
-(void)startNewArcadeGame;
// Scene will be replaced with a new game.
-(void)startNewInsaneGame;
// Scene will be replaced with a new game.
-(void)startNewFrenzyGame;
// Scene will be replaced with a new game.
// This will start another new game based off the previous game played.
-(void)startNewGame;


@end
