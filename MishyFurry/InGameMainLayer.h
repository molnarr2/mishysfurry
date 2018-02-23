//
//  InGameMainLayer.h
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InGameSpriteManager.h"
#import "InGameEngine.h"

@interface InGameMainLayer : CCLayer {
    InGameEngine *inGameEngine;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) sceneArcade;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) sceneFrenzy;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) sceneInsane;

-(void) update:(ccTime)delta;

// Sets up the game to do various game modes.
-(void) doInsaneGame;
-(void) doFrenzyGame;
-(void) doArcadeGame;

@end
