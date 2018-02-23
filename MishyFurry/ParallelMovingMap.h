//
//  ParallelMovingMap.h
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConfiguration.h"


@protocol ParallelMovingBlockProtocol<NSObject>

-(void) setScreenPosX:(float)x;
-(void) setScreenPosY:(float)y;
-(void) setScreenPos:(CGPoint)pt;

@end

@protocol ParallelMovingMapProtocol <NSObject>


-(NSArray<ParallelMovingBlockProtocol> *) requestNextStrip: (float) _xAbsolutePos;

@end


@interface ParallelMovingMap : NSObject {
    // The boardMap of blocks.
    id<ParallelMovingBlockProtocol> __strong **theGrid;
    // The measurements of the grid.
    int gridWidth;
    int gridHeight;
    // The current grid position of zero position on the screen.
    int gridPosition;
    // The offscreen grid buffer position where new blocks are loaded into.
    int gridLoadNewBlocksPosition;
    
    // The offset into the grid position. Once this becomes greater than blockSize than
    // the grid is incremented by one and a new row is loaded in.
    float offsetGridPos;
    
    // Block size.
    int blockSize;
    
    // The delegate for adding new blocks to the map.
    id<ParallelMovingMapProtocol> delegate;
}

// This will initialize the parallel moving map.
-(id) initParallelMovingMap: (id<ParallelMovingMapProtocol>)_delegate blockSize:(int)_blockSize;

// Update map with delta movement.
-(void) updateWithDelta: (float)_xDelta;

// This will load the next offscreen buffer position with blocks.
-(void) loadNextBufferIntoGrid;

// This will remove the blocks that are no more on the screen to be seen.
-(void) removeBlocks:(int)gridPos;

// This will calculate the screen position of the gridPos.
// @param gridPos is the grid position.
// @return the screen position of the gridPos.
-(float) gridToScreen:(int)gridPos;

// This will get block at the screen position.
// @param pt is a screen position.
// @return the block at the screen position, or nil if none exist there.
-(id<ParallelMovingBlockProtocol>) getBlockAtScreenPosition:(CGPoint)pt;

#pragma mark Grid Math on X axis

// This will increment the position to the next grid position. If beyond the grid
// then it will be zero.
// @param position to increment the position by 1.
// @return returns the next position, or zero if beyond the grid.
-(int) mathGridNext: (int)pos;

// This will add the distance from one point on the grid.
// @param pos is the current position.
// @param distance is the distance to add to the current position on the grid.
// @return a position on the grid.
-(int) mathGridAddDistance: (int)pos distance: (int)distance;

// This will calculate the distance from xFrom to xTo.
-(int) mathGridDistance: (int)xFrom to: (int)xTo;

-(void)gameCleanup;

@end
