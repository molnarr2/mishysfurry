//
//  BlockCell.h
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConfiguration.h"
#import "ParallelMovingMap.h"
#import "InGameSpriteManager.h"

enum blockCellType {
    // Player created block.
    blockPlayer,
    // Incoming block types.
    blockIncomingSmashable,   // Requires it to be smashed by the player block.
    blockIncomingTouchable,   // Requires it to be touched by the player to be removed.
    // Background blocks.
    blockBackgroundStatic,    // Background does nothing and is static.
    blockBackgroundTouchable, // Background that can be touched by the player.
};

enum blockcellColorType {
    blueblock,
    yellowblock,
    greenblock,
    redblock,
    tealblock,
    purpleblock,
    blackblock,
    orangeblock,
    powerblock, // Can smash through everything.
};

@interface BlockCell : NSObject<ParallelMovingBlockProtocol> {
    // The absolute position of the cell in pixels.
    CGPoint screenPosition;
    CCSprite *sprite;
    // The sprite for the extra hits.
    CCSprite *extraHits;
    
    // The type of block
    enum blockCellType blockType;
    
    // The color of the block.
    enum blockcellColorType blockColor;
    
    // The velocity of the block.
    CGPoint velocity;
    
    // Is invisible mode? Frames left is removed when the block is set. Not the best way to do it but
    // will work.
    bool invisibleMode;
    // Stays invisible until it gets to this screen position.
    float xInvisibleModeScreenPosition;
    // How many hit points it has.
    int life;
}

@property (nonatomic) CGPoint velocity;

-(id) initTheBlock:(enum blockCellType)_blockType blockColor:(enum blockcellColorType)_blockColor;

-(id) initTheBlock:(enum blockCellType)_blockType blockColor:(enum blockcellColorType)_blockColor life:(int)_life;

// This will create a clone of this block.
-(BlockCell *)clone;

// This will move the block by it's velocity and also add the external velocity.
-(void)animate:(CGPoint)externalVelocity;

// This will set the sprite of this block.
-(void)loadSprite;

// This will remove/load the life counter of a block.
-(void)loadLifeSpriteCounter;

// @return true if the block is dead and no longer needed in the game.
-(bool)isDead;

// @return true if the block is in the Spikezone.
-(bool)isInSpikeZone;

// @return true if block is touchable by the player.
-(bool)isTouchableBlock;

// @return true if block is smashable by player's block.
-(bool)isSmashable;

// @return true if block is a power block.
-(bool)isPowerBlock;

// This is a special checking based on the fact that all blocks are in the "Grid".
-(bool)hitOnTopBlock:(BlockCell *)cell;

// @return true if the location is within the block's cell.
-(bool)hitTouch:(CGPoint)location;

// @return true if the player block matches a smash block and color.
-(bool)matchPlayerToSmashedBlock: (BlockCell *)incomingCell;

// @return true if the block matches color and type.
-(bool)match: (BlockCell *)cell;

// @return true if the blocks match color type.
-(bool)matchColor:(BlockCell *)cell;

// @return true if the blocks match type.
-(bool)matchType:(BlockCell *)cell;

// This will set the block to as a player.
-(void)setToPlayerBlock;

// This will set block into invisible mode until it gets to this screen x position.
-(void)setInvisibleMode:(float)_xInvisibleModeScreenPosition;

// Decrement the life.
-(void)decrementLife;

// @return the number of lives this block has.
-(int)getLife;

// @return the current row position the block is currently in.
-(int)rowPosition;

// @return true if row position matches block's row position.
-(bool)isRowPosition:(int)rowPosition;

@end
