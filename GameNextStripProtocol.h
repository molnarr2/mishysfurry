//
//  GameNextStripProtocol.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 12/8/12.
//
//

#import <Foundation/Foundation.h>

enum smashableBlockType {
    smashableBlueBlock = 1,
    smashableBlueBlockX2 = 2,
    smashableBlueBlockX3 = 3,
    smashableYellowBlock = 4,
    smashableYellowBlockX2 = 5,
    smashableYellowBlockX3 = 6,
    smashableGreenBlock = 7,
    smashableGreenBlockX2 = 8,
    smashableGreenBlockX3 = 9,
    smashableRedBlock = 10,
    smashableRedBlockX2 = 11,
    smashableRedBlockX3 = 12,
    smashableTealBlock = 13,
    smashableTealBlockX2 = 14,
    smashableTealBlockX3 = 15,
    smashablePurpleBlock = 16,
    smashablePurpleBlockX2 = 17,
    smashablePurpleBlockX3 = 18,
    smashableOrangeBlock = 19,
    smashableOrangeBlockX2 = 20,
    smashableOrangeBlockX3 = 21,
    touchableBlock = 22,
    touchableBlockX2 = 23,
    touchableBlockX3 = 24
};


enum backgroundColorType {
    backgroundGreen,
    
    backgroundTeal,

    backgroundBlue,
    
    backgroundYellow,
    
    backgroundPurple,

    backgroundRed,

    backgroundOrange
};

@protocol GameNextStripProtocol <NSObject>

/** This will populate the 'backgroundBlocks' background blocks.
 * @param backgroundColor is the background color of the background blocks.
 * @param topCell is the top cell to be populated.
 * @param bottomCell is the bottom cell to be populated with.
 */
-(void) buildBackgroundBlocks: (enum backgroundColorType) backgroundColor topCell:(enum smashableBlockType)topCell bottomCell: (enum smashableBlockType)bottomCell;

/** This will add an incoming smashable block normal kind.
 * @param blockType is the smashable block type color.
 * @param incomingGridPos is the position within the valid incoming grid, ie, 0 to incomingBlockGridSize-1. This is the field minus the top and bottom blocks.
 */
-(void) addIncomingSmashable: (enum smashableBlockType)blockType incomingGridPos:(int)incomingGridPos;

/** This will add an incoming smashable block normal kind. Block starts off as invisible until it reaches the invisiblePos.
 * @param blockType is the smashable block type color.
 * @param incomingGridPos is the position within the valid incoming grid, ie, 0 to incomingBlockGridSize-1. This is the field minus the top and bottom blocks.
 * @param invisiblePos is the screen position when the block should become visible.
 */
-(void) addIncomingSmashableInvisible: (enum smashableBlockType)blockType incomingGridPos:(int)incomingGridPos invisiblePos:(int)invisiblePos;

/** Change velocity. This is done incrementally so as to be a smooth transistion for the user.
 * @param newVelocity is the new velocity to be used.
 */
-(void)changeVelocityTo:(float)newVelocity;

/** This will set the velocity instantly.
 * @param velocity is the velocity to set it to.
 */
-(void)setVelocityTo:(float)newVelocity;

@end
