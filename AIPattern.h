//
//  AIPattern.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 12/11/12.
//
//

#import <Foundation/Foundation.h>
#import "GameNextStripProtocol.h"
#import "GameConfiguration.h"

#define kEasyBackgroundType backgroundGreen

enum aiPatternDifficulty {
    difficultyEasy=1,
    difficultyNormal=2,
    difficultyMedium=3,
    difficultyHard=4,
    difficultyVeryHard=5,
    difficultyExtreme=6
    };


@protocol AIPatternProtocol <NSObject>
    /** This is called to set up the next column.
     * @return true if done with this pattern, else false continue to use it.
     */
    -(bool)nextColumn;

    -(void)setGameNextStripProtocol:(id<GameNextStripProtocol>)_inGame;

    /** Set the difficutly of the pattern.
    * @param _difficulty is the difficulty to set the pattern to.
     */
    -(void)setDifficulty:(enum aiPatternDifficulty)_difficulty;
@end

@interface AIPattern : NSObject<AIPatternProtocol> {
    /** The difficulty the pattern is currently on. */
    enum aiPatternDifficulty difficulty;
    
    /** The number of blocks these pattern has so far dollied out.*/
    int blockCount;
    /** The InGameEngine for generating the blocks. */
    id<GameNextStripProtocol> ingame;
    enum smashableBlockType topBlock;
    enum smashableBlockType bottomBlock;
    
    // Pattern to play back. The pattern will contain 6 rows. Top touchable, 4 playing, bottom touchable.
    int **patternPlayBack;
    int patternPosition;
    int patternLength;
    
    // Used for patterns of basic smash types to use.
    enum smashableBlockType a;
    enum smashableBlockType b;
    enum smashableBlockType c;
    enum smashableBlockType d;
    enum smashableBlockType e;
    enum smashableBlockType f;
    enum smashableBlockType g;
    enum smashableBlockType T; // Touchable
    int R; // Random value, it changes for each block of 'R'. It is set at pattern setup time.
    
}


/** SUBCLASS NOTE:
  * This function is required by the subclasses to overwrite so that columns are populated. This is
  * The function that is called to populate the background and incoming blocks. */
-(bool)_nextColumn;

// NEED TO DEALLOC THE PATTERNPLAYBACK.

/** This will setup for a pattern to playback.
 * @param patternSetup is the pattern to setup and playback. Must contain top touchable, 4 playing, and bottom touchable.
 * @param length is the length of the pattern to play back.
 */
-(void)setupPattern:(int *)patternSetup length:(int)length;
/** This will play the pattern.
 * @return true if the pattern is done playing, else false the pattern continues.
 */
-(bool)playPattern;
/** @return true if the pattern is done playing.
 */
-(bool)isPatternDone;


/* Gets a smashblock type based on the difficult of the level. Random color. Use this to keep with correct
 * color types.
 * @param lifeCount must be 1 to 3.
 */
-(enum smashableBlockType) getSmashBlock:(int)lifeCount;
/* Gets a smashblock type based on the difficult of the level. Random color. Use this to keep with correct
 * color types.
 * @param exclude is the type to exclude from getting.
 * @param lifeCount must be 1 to 3.
 */
-(enum smashableBlockType) getSmashBlockExclude:(enum smashableBlockType)exclude lifeCount:(int)lifeCount;
/** Compares and see if the two smashableBlockType are the same, ie, life count of block doesn't count.
 * @return true if they match (even if life count aren't the same).
 */
-(bool)blocksMatch:(enum smashableBlockType)block1 block2:(enum smashableBlockType)block2;

/** @return the background block type based on difficulty.
 */
-(enum backgroundColorType) getBackgroundBlock;

/** Used to convert a smashable block into one with life if need be.
  * @param smashBlock is a single life smashable block.
  * @param lifeCount is 1 to 3
  * @return smashable block with life upgrade. If parameters are invalid then it will return a yellow smashable.
  */
-(enum smashableBlockType) smashableBlockUpgradeWithLife:(enum smashableBlockType)smashBlock lifeCount:(int)lifeCount;

/** Setup of the usable smash block types to use.
 */
-(void)setupSmashables;

// ----------------------------------

/** This will add an incoming smashable at a random position.
 */
-(void) randomSingle: (enum smashableBlockType)block;

/** This will add an incoming smashable at a random position.
 */
-(void) randomSingle: (enum smashableBlockType)block1 block2:(enum smashableBlockType)block2;

/** Adds the incoming smashable at random position pos1 or pos2.
 */
-(void) randomSingle: (enum smashableBlockType)block pos1:(int)pos1 pos2:(int)pos2;

/** This adds two incoming smashable at a random position. Random block but same two.
 */
-(void) randomDouble: (enum smashableBlockType)block1 block2:(enum smashableBlockType)block2;

/** This adds two incoming smashable at a random position. One will be a touchable.
 */
-(void) randomSingleTochable: (enum smashableBlockType)block;

/** This will add an incoming smashable at a random position but starts off invisible.
 */
-(void) randomSingleInvisible: (enum smashableBlockType)block;


@end
