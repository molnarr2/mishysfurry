//
//  InGameEngine.m
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//
//

#import "InGameEngine.h"

@implementation InGameEngine

@synthesize gameOver;

-(id) init {
    if( (self=[super init])) {
        gameOver = false;
        changeVelocity = false;
        velocity = 3.5;
        blockDistance = 0;
        int playerLives = 5;
        
        livingObjectEngine = [[LivingObjectsEngine alloc] init];
        hudDisplay = [[HUDdisplay alloc] initHUDdisplay:playerLives];
        
        gridHeight = (int)ceil((float)kDeviceHeight / (float)kGameBlockSize);
    }
    
    return self;
}

-(void) touchAt:(CGPoint) location
{
    if (!gameOver) {
        // Did user touch an out block to send a new player block?
        BlockCell *bCell = [parallelMovingMap getBlockAtScreenPosition:location];
        if ([bCell isTouchableBlock]) {
            BlockCell *cloned = [bCell clone];
            [cloned setToPlayerBlock];
            
            [livingObjectEngine addPlayerBlock:cloned];
            return;
        }
        
        // Did user touch a touchable incoming block?
        [livingObjectEngine touchAt:location];
        [hudDisplay addToPlayerScore:[livingObjectEngine getPlayerPoints]];
    }
}


-(void) update
{
    [livingObjectEngine updateWithDelta:velocity];
    
    // This should be last.
    [parallelMovingMap updateWithDelta:velocity];

    if (!gameOver) {
        // Add the player points.
        [hudDisplay addToPlayerScore:[livingObjectEngine getPlayerPoints]];
        
        // Did the player lose lives?
        int lostLives = [livingObjectEngine getPlayerLostLives];
        if (lostLives) {
            [hudDisplay playerLosesLives:lostLives];
            // Did the player finish the game?
            if (![hudDisplay hasPlayerLivesLeft]) {
                [self endGame];
            }
        }
    }

    // Transition the velocity.
    if (changeVelocity) {
        if (fabs(velocity - velocityTo) < 0.015) {
            velocity = velocityTo;
            changeVelocity = false;
        } else if (velocityTo - velocity > 0.0) {
            velocity += 0.01;
        } else
            velocity -= 0.01;
    }
    
   // velocity += 1.0 / 60.0;
}

-(void) endGame
{
    gameOver = true;
    
    id<EndGameLayerProtocol> endGameMenuLayer = (id<EndGameLayerProtocol>)[CCBReader nodeGraphFromFile:@"EndGameLayer.ccbi"];
    [endGameMenuLayer setScore:[self getPlayerScore]];
    CCScene *scene = [[CCDirector sharedDirector] runningScene];
    CCLayer *layer = (CCLayer *)[scene getChildByTag:52000];
    
    [layer addChild:endGameMenuLayer];
}

-(int) getPlayerScore
{
    return [hudDisplay getPlayerScore];
}

-(void) doInsaneGame
{
    computerPlayer = [[ComputerPlayer alloc] initComputerPlayer:insaneComputer];
    computerPlayer.ingame = self;
    parallelMovingMap = [[ParallelMovingMap alloc] initParallelMovingMap:self blockSize:kGameBlockSize];
}

-(void) doFrenzyGame
{
    computerPlayer = [[ComputerPlayer alloc] initComputerPlayer:frenzyComputer];
    computerPlayer.ingame = self;
    parallelMovingMap = [[ParallelMovingMap alloc] initParallelMovingMap:self blockSize:kGameBlockSize];
}

-(void) doArcadeGame
{
    computerPlayer = [[ComputerPlayer alloc] initComputerPlayer:arcadeComputer];
    computerPlayer.ingame = self;
    parallelMovingMap = [[ParallelMovingMap alloc] initParallelMovingMap:self blockSize:kGameBlockSize];
}

-(void)gameCleanup
{
    NSLog(@"InGameEngine::gameCleanup");
    
    [parallelMovingMap gameCleanup];
    parallelMovingMap = nil;
    [livingObjectEngine gameCleanup];
    livingObjectEngine = nil;
    hudDisplay = nil;
    computerPlayer.ingame = nil;
    computerPlayer = nil;
}

-(enum blockcellColorType)smashableToColorType:(enum smashableBlockType)smashable
{
    switch (smashable) {
        case smashableBlueBlock:
            return blueblock;
        case smashableBlueBlockX2:
            return blueblock;
        case smashableBlueBlockX3:
            return blueblock;
            
        case smashableYellowBlock:
            return yellowblock;
        case smashableYellowBlockX2:
            return yellowblock;
        case smashableYellowBlockX3:
            return yellowblock;
            
        case smashableGreenBlock:
            return greenblock;
        case smashableGreenBlockX2:
            return greenblock;
        case smashableGreenBlockX3:
            return greenblock;
            
        case smashableRedBlock:
            return redblock;
        case smashableRedBlockX2:
            return redblock;
        case smashableRedBlockX3:
            return redblock;
            
        case smashableTealBlock:
            return tealblock;
        case smashableTealBlockX2:
            return tealblock;
        case smashableTealBlockX3:
            return tealblock;
            
        case smashablePurpleBlock:
            return purpleblock;
        case smashablePurpleBlockX2:
            return purpleblock;
        case smashablePurpleBlockX3:
            return purpleblock;
            
        case smashableOrangeBlock:
            return orangeblock;
        case smashableOrangeBlockX2:
            return orangeblock;
        case smashableOrangeBlockX3:
            return orangeblock;
    }
}

#pragma mark ParallelMovingMapProtocol

-(NSArray<ParallelMovingBlockProtocol> *) requestNextStrip: (float) _xAbsolutePos
{
    xAbsolutePos = _xAbsolutePos;
    
    // Create the array of background blocks.
    backgroundBlocks = [[NSMutableArray alloc] initWithCapacity:gridHeight];
    
    // Have the computer player build the background blocks and incoming blocks.
    [computerPlayer buildNextBlockColumn:xAbsolutePos blockDistance:blockDistance];
    
    // Go the next block distance.
    blockDistance++;
    
    // Return the populated background blocks.
    return (NSArray<ParallelMovingBlockProtocol> *)backgroundBlocks;
}

#pragma mark GameNextStripProtocol

-(void) buildBackgroundBlocks: (enum backgroundColorType) backgroundColor topCell:(enum smashableBlockType)topCell bottomCell: (enum smashableBlockType)bottomCell
{
    BlockCell *cell;

    // Do note the blocks are flipped so that top cell is literally the top block on the device.
    
    // Top cell.
    BlockCell *tCell = [[BlockCell alloc] initTheBlock:blockBackgroundTouchable blockColor:[self smashableToColorType:bottomCell]];
    tCell.velocity = CGPointMake(0, 15);
    [backgroundBlocks addObject:tCell];

    // Populate with background blocks.
    for (int i=1; i < gridHeight-1; i++) {
        switch (backgroundColor) {
            case backgroundBlue:
                cell = [[BlockCell alloc]initTheBlock:blockBackgroundStatic blockColor:blueblock];
                break;
            case backgroundYellow:
                cell = [[BlockCell alloc]initTheBlock:blockBackgroundStatic blockColor:yellowblock];
                break;
            case backgroundGreen:
                cell = [[BlockCell alloc]initTheBlock:blockBackgroundStatic blockColor:greenblock];
                break;
            case backgroundRed:
                cell = [[BlockCell alloc]initTheBlock:blockBackgroundStatic blockColor:redblock];
                break;
            case backgroundOrange:
                cell = [[BlockCell alloc]initTheBlock:blockBackgroundStatic blockColor:orangeblock];
                break;
            case backgroundTeal:
                cell = [[BlockCell alloc]initTheBlock:blockBackgroundStatic blockColor:tealblock];
                break;
            case backgroundPurple:
                cell = [[BlockCell alloc]initTheBlock:blockBackgroundStatic blockColor:purpleblock];
                break;
        }
        
        [backgroundBlocks addObject:cell];
    }

    // Bottom cell.
    BlockCell *bCell = [[BlockCell alloc] initTheBlock:blockBackgroundTouchable blockColor:[self smashableToColorType:topCell]];
    bCell.velocity = CGPointMake(0, -15);
    [backgroundBlocks addObject:bCell];
}

-(void) addIncomingSmashable: (enum smashableBlockType)blockType incomingGridPos:(int)incomingGridPos
{
    if (blockType == 0)
        return;
    
    [self addIncomingSmashableInvisible:blockType incomingGridPos:incomingGridPos invisiblePos:0];
}

-(void) addIncomingSmashableInvisible: (enum smashableBlockType)blockType incomingGridPos:(int)incomingGridPos invisiblePos:(int)invisiblePos
{
    // Create the block.
    BlockCell *cell = nil;
    
    switch (blockType) {
        case smashableBlueBlock:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:blueblock];
            break;
        case smashableBlueBlockX2:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:blueblock life:2];
            break;
        case smashableBlueBlockX3:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:blueblock life:3];
            break;
        case smashableYellowBlock:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:yellowblock];
            break;
        case smashableYellowBlockX2:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:yellowblock life:2];
            break;
        case smashableYellowBlockX3:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:yellowblock life:3];
            break;
        case smashableGreenBlock:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:greenblock];
            break;
        case smashableGreenBlockX2:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:greenblock life:2];
            break;
        case smashableGreenBlockX3:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:greenblock life:3];
            break;
        case smashableRedBlock:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:redblock];
            break;
        case smashableRedBlockX2:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:redblock life:2];
            break;
        case smashableRedBlockX3:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:redblock life:3];
            break;
        case smashableTealBlock:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:tealblock];
            break;
        case smashableTealBlockX2:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:tealblock life:2];
            break;
        case smashableTealBlockX3:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:tealblock life:3];
            break;
        case smashablePurpleBlock:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:purpleblock];
            break;
        case smashablePurpleBlockX2:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:purpleblock life:2];
            break;
        case smashablePurpleBlockX3:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:purpleblock life:3];
            break;
        case smashableOrangeBlock:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:orangeblock];
            break;
        case smashableOrangeBlockX2:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:orangeblock life:2];
            break;
        case smashableOrangeBlockX3:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingSmashable blockColor:orangeblock life:3];
            break;
        case touchableBlock:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingTouchable blockColor:blackblock];
            break;
        case touchableBlockX2:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingTouchable blockColor:blackblock life:2];
            break;
        case touchableBlockX3:
            cell = [[BlockCell alloc]initTheBlock:blockIncomingTouchable blockColor:blackblock life:3];
            break;
    }
    
    if (invisiblePos > 0)
        [cell setInvisibleMode:invisiblePos];
    
    // Set block position.
    
    // Validate grid position.
    if (incomingGridPos < 0)
        incomingGridPos = 0;
    else if (incomingGridPos >= kIncomingFieldSize)
        incomingGridPos = kIncomingFieldSize - 1;
    
    CGPoint pt;
    pt.x = xAbsolutePos;
    pt.y = (kIncomingFieldSize - incomingGridPos) * kGameBlockSize;
    [cell setScreenPos:pt];
    
    // Now add it to the living objects.
    [livingObjectEngine addIncomingBlocks:cell];
}

-(void)changeVelocityTo:(float)newVelocity
{
    changeVelocity = true;
    velocityTo = newVelocity;
}

-(void)setVelocityTo:(float)newVelocity
{
    velocity = newVelocity;
}

- (void) dealloc
{
}


@end

