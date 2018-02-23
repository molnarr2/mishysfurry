//
//  ComputerPlayer.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 12/7/12.
//
//

#import <Foundation/Foundation.h>
#import "BlockCell.h"
#import "GameConfiguration.h"
#import "GameNextStripProtocol.h"
#import "AIPattern.h"
#import "AIPatternSundry.h"


enum computerPlayerType {
    insaneComputer,
    frenzyComputer,
    arcadeComputer,
};


/** This class is used to populate a strip of blocks column wise (on the x axis). The buildNextBlockColumn() function is the entry function used to 
 * populate the columns. Check out that buildNextBlockColumn() function.
 */
@interface ComputerPlayer : NSObject {
    // The InGameEngine used to populate with blocks.
    id<GameNextStripProtocol> ingame;
    // This is the computer type being played, ie, which game mode basically.
    enum computerPlayerType computerPlayerType;
    // The screen x position where the incoming blocks should be placed.
    float xAbsolutePos;
    // The current block distance being populated.
    int blockDistance;
    // The number of blocks in the valid game playing field for incoming blocks.
    int incomingBlockGridSize;
    // The currently used pattern.
    id<AIPatternProtocol> currentPattern;
    // The current difficulty of the computer player.
    enum aiPatternDifficulty difficulty;
    
    // Random generated number everytime new game. 0 - 1000
    int randomThousand;
    // A toggle flag used for the patterns.
    bool aToggleFlag;
}

@property(strong) id<GameNextStripProtocol> ingame;

-(id) initComputerPlayer: (enum computerPlayerType)_computerPlayerType;

/** This is called to get the next strip of blocks. The computer has control of how this is to be done.
 * @param xAbsolutePos is the absolute position in screen coordinates where these blocks will be placed at.
 * @param blockDistance is the number of block columns that have been populated already. Note when the screen starts it will already be past zero for each block the game populates before screen is shown.
 */
-(void) buildNextBlockColumn: (float)_xAbsolutePos blockDistance: (int)_blockDistance;

/** This is the centralized brain function for new strips of background and incoming blocks.
 */
-(void) computerTime;

/** The following functions are called by the brain function (computerTime) when it needs a
 * new pattern to run. These are based on which game type the player selected.
 */
-(id<AIPatternProtocol>) newArcadePattern;
-(id<AIPatternProtocol>) newFrenzyPattern;
-(id<AIPatternProtocol>) newInsanePattern;

@end
