//
//  ParallelMovingMap.m
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//
//

#import "ParallelMovingMap.h"

@implementation ParallelMovingMap

-(id) initParallelMovingMap: (id<ParallelMovingMapProtocol>)_delegate blockSize:(int)_blockSize {

    if( (self=[super init])) {
        delegate = _delegate;
        blockSize = _blockSize;
        
        gridHeight = (int)ceil((float)kDeviceHeight / (float)blockSize);
        gridWidth = (int)ceil((float)kDeviceWidth / (float)blockSize) + 8;
        
        gridPosition = 0;
        gridLoadNewBlocksPosition = 0;
        offsetGridPos = 0.0;
        
        // Allocate the memory for the 'theGrid'.
        theGrid = (id<ParallelMovingBlockProtocol> __strong **)calloc(sizeof(id), gridWidth);
        for (int x=0; x < gridWidth; x++) {
            theGrid[x] = (id<ParallelMovingBlockProtocol> __strong *)calloc(sizeof(id), gridHeight);
            
            for (int y=0; y < gridHeight; y++) {
                theGrid[x][y] = nil;
            }
        }

        // Load in the blocks.
        int screenWidthBlocks = (int)ceil((float)kDeviceWidth / (float)blockSize) + 2;
        for (int i=0; i < screenWidthBlocks; i++)
            [self loadNextBufferIntoGrid];
    }
    
    return self;
}

-(void) dealloc
{
 //   if (theGrid == nil)
 //       return;
    
 //   for (int x=0; x < gridWidth; x++) {
 //       for (int y=0; y < gridHeight; y++) {
 //           theGrid[x][y] = nil;
 //       }
 //       free(theGrid[x]);
 //   }
 //   free(theGrid);
}

-(void) updateWithDelta: (float)_xDelta {
    offsetGridPos += _xDelta;
    
    // Update all block's x position.
    for (int x=0; x < gridWidth; x++) {
        if (theGrid[x][0] == nil)
            continue;
        
        // Update the block's x position.
        float xScreenPosition = [self gridToScreen:x];
        for (int y=0; y < gridHeight; y++) {
            [theGrid[x][y] setScreenPosX:xScreenPosition];
        }
    }
    
    // Is it time for a new loading of blocks and removal of the old ones.
    if (offsetGridPos >= (blockSize + blockSize / 2)) {
        offsetGridPos -= blockSize;
        int oldGridPosition = gridPosition;
        gridPosition = [self mathGridNext:gridPosition];
        
        // Load in next buffer of blocks.
        [self loadNextBufferIntoGrid];
        
        // Remove the old buffer of blocks.
        [self removeBlocks:oldGridPosition];
    }
    
}

-(void) removeBlocks:(int)gridPos
{
    for (int y=0; y<gridHeight; y++) {
        theGrid[gridPos][y] = nil;
    }
}

-(float) gridToScreen:(int)gridPos
{
    int distance = [self mathGridDistance:gridPosition to:gridPos];
    return (float)distance * (float)blockSize - offsetGridPos;
}

-(void) loadNextBufferIntoGrid {
    float xScreenPosition = [self gridToScreen:gridLoadNewBlocksPosition];
    
    // Load the blocks into the grid.
    NSArray<ParallelMovingBlockProtocol> *arrBlocks = [delegate requestNextStrip:xScreenPosition];
    if ([arrBlocks count] < gridHeight)
        NSAssert(false, @"Did not get enough blocks for the map: %d %d.", [arrBlocks count], gridHeight);
    
    for (int y=0; y<gridHeight; y++) {
        theGrid[gridLoadNewBlocksPosition][y] = [arrBlocks objectAtIndex:y];
        [theGrid[gridLoadNewBlocksPosition][y] setScreenPos:CGPointMake(xScreenPosition, (y*blockSize))];
    }
    
    gridLoadNewBlocksPosition = [self mathGridNext:gridLoadNewBlocksPosition];
}


-(id<ParallelMovingBlockProtocol>) getBlockAtScreenPosition:(CGPoint)pt
{
    float xBlockDistanceToGridPos = (offsetGridPos + pt.x) / blockSize;
    int xBlockDistance = lroundf(xBlockDistanceToGridPos);
    int xGridPos = [self mathGridAddDistance:gridPosition distance:xBlockDistance];
    
    float yBlockDistance = pt.y / blockSize;
    int yGridPos = lroundf(yBlockDistance);

    if (xGridPos < 0 || xGridPos >= gridWidth)
        return nil;
    if (yGridPos < 0 || yGridPos >= gridHeight)
        return nil;
    return theGrid[xGridPos][yGridPos];
}

#pragma mark Grid Math on X axis

-(int) mathGridNext: (int)pos {
    pos++;
    if (pos >= gridWidth)
        return 0;
    return pos;
}

-(int) mathGridAddDistance: (int)pos distance: (int)distance
{
    pos += distance;
    while (true) {
        if (pos < gridWidth)
            break;
        pos -= gridWidth;
    }
    return pos;
}

-(int) mathGridDistance: (int)xFrom to: (int)xTo {
    if (xTo > xFrom)
        return xTo - xFrom;
    return gridWidth - xFrom + xTo;
}

-(void)gameCleanup
{
       for (int x=0; x < gridWidth; x++) {
           for (int y=0; y < gridHeight; y++) {
               theGrid[x][y] = nil;
           }
           free(theGrid[x]);
       }
       free(theGrid);
}

@end
