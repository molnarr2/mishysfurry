//
//  InGameEngine.h
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConfiguration.h"
#import "ParallelMovingMap.h"
#import "BlockCell.h"
#import "LivingObjectsEngine.h"
#import "CCBReader.h"
#import "EndGameLayerProtocol.h"
#import "HUDdisplay.h"
#import "ComputerPlayer.h"
#import "GameNextStripProtocol.h"

@interface InGameEngine : NSObject<ParallelMovingMapProtocol, GameNextStripProtocol> {
    ParallelMovingMap *parallelMovingMap;
    LivingObjectsEngine *livingObjectEngine;
    HUDdisplay *hudDisplay;
    ComputerPlayer *computerPlayer; // Ie, the brains behind what blocks are coming.
    NSMutableArray *backgroundBlocks; // Used by the requestNextStrip() function and then the GameNextStripProtocol protocol.
    
    // How fast the game is moving.
    float velocity;
    float velocityTo;
    bool changeVelocity;
    
    // Is the game over?
    bool gameOver;
    // The number of blocks the player has gone so far.
    int blockDistance;
    
    // This is the grid height.
    int gridHeight;
    
    // The screen x absolute position for the next strip of blocks.
    float xAbsolutePos;
}

@property(nonatomic) bool gameOver;

-(void) touchAt:(CGPoint) location;

-(void) update;

// @return the player score.
-(int) getPlayerScore;

// Sets up the game to do various game modes.
-(void) doInsaneGame;
-(void) doFrenzyGame;
-(void) doArcadeGame;

// Call this to end the game.
-(void) endGame;

-(void)gameCleanup;

-(enum blockcellColorType)smashableToColorType:(enum smashableBlockType)smashable;


@end
