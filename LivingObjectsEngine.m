//
//  LivingObjectsEngine.m
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/3/12.
//
//

#import "LivingObjectsEngine.h"

@implementation LivingObjectsEngine

-(id) init {
    if( (self=[super init])) {
        arrPlayerBlocks = [[NSMutableArray alloc] initWithCapacity:100];
        arrIncomingBlocks = [[NSMutableArray alloc] initWithCapacity:100];
        arrRemovePlayerBlocks = [[NSMutableArray alloc] initWithCapacity:100];
        arrRemoveIncomingBlocks = [[NSMutableArray alloc] initWithCapacity:100];
        playerLostLives = 0;
        playerPoints = 0;
        
        arrSpikes[0] = [[Spike alloc] initTheSpike:3 screenPosition:CGPointMake(69, 150.0)];
        arrSpikes[1] = [[Spike alloc] initTheSpike:3 screenPosition:CGPointMake(69, 300.0)];
        arrSpikes[2] = [[Spike alloc] initTheSpike:3 screenPosition:CGPointMake(69, 450.0)];
        arrSpikes[3] = [[Spike alloc] initTheSpike:3 screenPosition:CGPointMake(69, 600.0)];
    }
    
    return self;
}

-(void)touchAt:(CGPoint) location
{
    // Did the player touch the cell if so then delete it.
    BlockCell *foundCell = nil;
    for (BlockCell *incomingBlock in arrIncomingBlocks) {
        if ([incomingBlock isTouchableBlock] && [incomingBlock hitTouch:location]) {
            // Decrement the life of the incoming block.
            [incomingBlock decrementLife];
            
            // No more life to the block.
            if ([incomingBlock getLife] <= 0) {
                playerPoints++;
                foundCell = incomingBlock;
            }
            
            break;
        }
    }
    
    [arrIncomingBlocks removeObject:foundCell];
}

-(void)addPlayerBlock:(BlockCell *)cell
{
    [arrPlayerBlocks addObject:cell];
}

-(void)addIncomingBlocks:(BlockCell *)cell
{
    [arrIncomingBlocks addObject:cell];
}

-(void)updateWithDelta:(float)delta
{
    // Update the block's positions.
    CGPoint externalVelocity;
    externalVelocity.y = 0;
    externalVelocity.x = -delta;
    
    int lightningStrikingPosition[4]; // This is the lightning strike position.
    for (int i=0; i < 4; i++) {
        lightningStrikingPosition[i] = 0;
    }
    
    
    for (BlockCell *cell in arrPlayerBlocks) {
        [cell animate:externalVelocity];
    }
    
    for (BlockCell *cell in arrIncomingBlocks) {
        [cell animate:externalVelocity];
    }

    // Perform colision on player blocks to the incoming blocks.
    BlockCell *removeIncoming = nil;
    for (BlockCell *playerBlock in arrPlayerBlocks) {
        for (BlockCell *incomingBlock in arrIncomingBlocks) {
            
            // Player has hit an incoming block.
            if ([playerBlock hitOnTopBlock:incomingBlock]) {
                bool bPowerBlock = [playerBlock isPowerBlock];
                // Power blocks continue no matter what.
                if (!bPowerBlock)
                    [arrRemovePlayerBlocks addObject:playerBlock];

                // Player's block must match a smashed block and block color.
                if (bPowerBlock || [playerBlock matchPlayerToSmashedBlock:incomingBlock]) {
                    // Decrement the life of the incoming block.
                    [incomingBlock decrementLife];

                    // Player successfully hit block.
                    if ([incomingBlock getLife] <= 0 || bPowerBlock) {
                        removeIncoming = incomingBlock;
                        playerPoints++;
                    }
                } else {
                    // Player sent wrong color block or the player block hit a touchable one.
                    playerLostLives++;
                }
                
                break;
            }
        }
        
        // Remove the incoming block.
        if (removeIncoming != nil) {
            [arrIncomingBlocks removeObject:removeIncoming];
            removeIncoming = nil;
        }
    }

    // Find dead blocks to remove.
    for (BlockCell *cell in arrPlayerBlocks) {
        if ([cell isDead])
            [arrRemovePlayerBlocks addObject:cell];
    }
    // Incoming blocks that were missed. Player loses a live.
    for (BlockCell *cell in arrIncomingBlocks) {
        
        // Within the spike zone to kill the block.
        if ([cell isInSpikeZone]) {
            int rowPosition = [cell rowPosition];
            // This is just in case the row position is beyond the spikes which it shouldn't be.
            if (rowPosition == 0 || rowPosition == 5) {[arrRemoveIncomingBlocks addObject:cell];}

            // Decrease the spike's life and shot out lightening.
            Spike *spike = arrSpikes[rowPosition-1];
            bool shouldLightening = [spike decrementLife];
            if (shouldLightening) {
                // Shoot out a lightning.
                [spike lightningStrikes];
                lightningStrikingPosition[rowPosition-1] = 1;
            } else {
                // Spike has no life left, just let the block continue until dead.
                if ([cell isDead]) {
                    [arrRemoveIncomingBlocks addObject:cell];
                    playerLostLives++;
                }
            }
        }
    }

    // Remove all blocks that are in the row of the spike that initiated it.
    for (int i=0; i < 4; i++) {
        if (lightningStrikingPosition[i]) {
            for (BlockCell *cell in arrIncomingBlocks) {
                if ([cell isRowPosition:i+1])
                    [arrRemoveIncomingBlocks addObject:cell];
            }
        }
    }
    
    // Now purge all player blocks.
    for (BlockCell *block in arrRemovePlayerBlocks) {
        [arrPlayerBlocks removeObject:block];
    }
    [arrRemovePlayerBlocks removeAllObjects];
    
    // Now purge all incoming blocks.
    for (BlockCell *block in arrRemoveIncomingBlocks) {
        [arrIncomingBlocks removeObject:block];
    }
    [arrRemoveIncomingBlocks removeAllObjects];
}

-(int)getPlayerLostLives
{
    int tmp = playerLostLives;
    playerLostLives = 0;
    return tmp;
}

-(int)getPlayerPoints
{
    int tmp = playerPoints;
    playerPoints = 0;
    return tmp;
}

-(void)gameCleanup
{
    [arrIncomingBlocks removeAllObjects];
    [arrPlayerBlocks removeAllObjects];
}

@end
