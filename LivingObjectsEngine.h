//
//  LivingObjectsEngine.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/3/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConfiguration.h"
#import "BlockCell.h"
#import "Spike.h"

@interface LivingObjectsEngine : NSObject {
    // Player created blocks. (BlockCell)
    NSMutableArray *arrPlayerBlocks;
    // Incoming blocks that need to be defeated. (BlockCell)
    NSMutableArray *arrIncomingBlocks;
    // Player blocks that need to be removed. (BlockCell)
    NSMutableArray *arrRemovePlayerBlocks;
    // Incoming blocks that need to be removed. (BlockCell)
    NSMutableArray *arrRemoveIncomingBlocks;
    
    // The number of lives the player has lost so far.
    int playerLostLives;
    // The number of points the player has raked up so far.
    int playerPoints;
    // The spikes that protect against game over. Only 4 are needed since they are at the left side.
    Spike *arrSpikes[4];
}

// This will add the block to the players array of blocks.
-(void)addPlayerBlock:(BlockCell *)cell;

// This will add the block to the incoming array of blocks.
-(void)addIncomingBlocks:(BlockCell *)cell;

// Move all blocks by delta.
-(void)updateWithDelta:(float)delta;

// User touchable blocks.
-(void)touchAt:(CGPoint) location;

// When this is call it will rest the player lost lives count.
// @return the number of lives the player has lost.
-(int)getPlayerLostLives;

// When this is called it will rest the player points.
// @return the number of player points the player got.
-(int)getPlayerPoints;

-(void)gameCleanup;

@end
