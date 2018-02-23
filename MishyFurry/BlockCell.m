//
//  BlockCell.m
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//
//

#import "BlockCell.h"

@implementation BlockCell

@synthesize velocity;

-(id) initTheBlock:(enum blockCellType)_blockType blockColor:(enum blockcellColorType)_blockColor
{
    return [self initTheBlock:_blockType blockColor:_blockColor life:1];
}

-(id) initTheBlock:(enum blockCellType)_blockType blockColor:(enum blockcellColorType)_blockColor life:(int)_life
{
	if( (self=[super init])) {
        blockColor = _blockColor;
        blockType = _blockType;
        life = _life;
        extraHits = nil;
        [self loadSprite];
        [self loadLifeSpriteCounter];
    }
    return self;
    
}

-(BlockCell *)clone
{
    BlockCell *newCell = [[BlockCell alloc] initTheBlock:blockType blockColor:blockColor life:life];
    newCell->screenPosition.x = screenPosition.x;
    newCell->screenPosition.y = screenPosition.y;
    newCell->velocity.x = velocity.x;
    newCell->velocity.y = velocity.y;

    return newCell;
}

-(void)animate:(CGPoint)externalVelocity
{
    screenPosition.x += velocity.x + externalVelocity.x;
    screenPosition.y += velocity.y + externalVelocity.y;
    [sprite setPosition:screenPosition];
    [extraHits setPosition:screenPosition];
    
    if (invisibleMode) {
        if (screenPosition.x < xInvisibleModeScreenPosition) {
            [sprite setVisible:true];
            [extraHits setVisible:true];
            invisibleMode = false;
        }
    }
}

-(void)loadSprite
{
    if (blockColor == blueblock) {
        sprite = [[InGameSpriteManager shared] newInGameSprite:kBlueBlock];
    } else if (blockColor == yellowblock) {
        sprite = [[InGameSpriteManager shared] newInGameSprite:kYellowBlock];
    } else if (blockColor == greenblock) {
        sprite = [[InGameSpriteManager shared] newInGameSprite:kGreenBlock];
    } else if (blockColor == redblock) {
        sprite = [[InGameSpriteManager shared] newInGameSprite:kRedBlock];
    } else if (blockColor == tealblock) {
        sprite = [[InGameSpriteManager shared] newInGameSprite:kTealBlock];
    } else if (blockColor == purpleblock) {
        sprite = [[InGameSpriteManager shared] newInGameSprite:kPurpleBlock];
    } else if (blockColor == orangeblock) {
        sprite = [[InGameSpriteManager shared] newInGameSprite:kOrangeBlock];
    } else if (blockColor == blackblock) {
        sprite = [[InGameSpriteManager shared] newInGameSprite:kBlackBlock];
    } else if (blockColor == powerblock) {
        sprite = [[InGameSpriteManager shared] newInGameSprite:kPowerBlock];
    }
    
    if (blockType == blockBackgroundStatic) {
        sprite.opacity = 128;
        [sprite setZOrder:-10];
    }
}

-(void)loadLifeSpriteCounter
{
    if (extraHits) {
        [[InGameSpriteManager shared] removeInGameSprite:extraHits];
        extraHits = nil;
    }
    if (life == 2) {
        extraHits = [[InGameSpriteManager shared] newInGameSprite:kX2];
    } else if (life == 3) {
        extraHits = [[InGameSpriteManager shared] newInGameSprite:kX3];
    }
}

-(bool)isDead
{
    if (screenPosition.x < -kGameBlockSize) {
        return true;
    } else if (velocity.y > 0) {
        if (screenPosition.y >= kDeadUserBlocksYPlus)
            return true;
    } else if (velocity.y < 0){
        if (screenPosition.y <= kDeadUserBlocksYMinus)
            return true;
    }
    
    return false;
}

-(bool)isInSpikeZone
{
    if (screenPosition.x < kGameBlockSizeRadius + kGameBlockSize)
        return true;
    return false;
}

-(bool)isTouchableBlock
{
    if (blockType == blockIncomingTouchable || blockType == blockBackgroundTouchable)
        return true;
    return false;
}

-(bool)isSmashable
{
    if (blockType == blockIncomingSmashable)
        return true;
    return false;
}

-(bool)isPowerBlock
{
    if (blockColor == powerblock)
        return true;
    return false;
}

-(bool)matchPlayerToSmashedBlock: (BlockCell *)incomingCell
{
    if (blockType == blockPlayer && incomingCell->blockType == blockIncomingSmashable && blockColor == incomingCell->blockColor)
        return true;
    return false;
}

-(bool)match:(BlockCell *)cell
{
    if (blockColor == cell->blockColor && blockType == cell->blockType)
        return true;
    return false;
}

-(bool)matchColor:(BlockCell *)cell
{
    if (blockColor == cell->blockColor)
        return true;
    return false;
}

-(bool)matchType:(BlockCell *)cell
{
    if (blockType == cell->blockType)
        return true;
    return false;
}

-(bool)hitOnTopBlock:(BlockCell *)cell
{
    if (invisibleMode)
        return false;
    
    float xdiff = cell->screenPosition.x - screenPosition.x;
    if (xdiff > 1.0 || xdiff < -1.0)
        return false;
    float ydiff = cell->screenPosition.y - screenPosition.y;
    if (ydiff < 5.0 && ydiff > -5.0) {
        return true;
    }
    
    return false;
}

-(bool)hitTouch:(CGPoint)location
{
    if (invisibleMode)
        return false;
    
    float xdiff = location.x - screenPosition.x;
    if (xdiff > kGameBlockSizeRadius || xdiff < -kGameBlockSizeRadius)
        return false;
    float ydiff = location.y - screenPosition.y;
    if (ydiff < kGameBlockSizeRadius && ydiff > -kGameBlockSizeRadius) {
        return true;
    }
    
    return false;
}

-(void) setScreenPosX:(float)x
{
    screenPosition.x = x;
    [sprite setPosition:screenPosition];
    [extraHits setPosition:screenPosition];
    
    if (invisibleMode) {
        if (screenPosition.x < xInvisibleModeScreenPosition) {
        [sprite setVisible:true];
        [extraHits setVisible:true];
        invisibleMode = false;
        }
    }
}

-(void) setScreenPosY:(float)y
{
    screenPosition.y = y;
    [sprite setPosition:screenPosition];
    [extraHits setPosition:screenPosition];
}

-(void) setScreenPos:(CGPoint)pt
{
    screenPosition.x = pt.x;
    screenPosition.y = pt.y;
    [sprite setPosition:screenPosition];
    [extraHits setPosition:screenPosition];

    if (invisibleMode) {
        
        if (screenPosition.x < xInvisibleModeScreenPosition) {
        [sprite setVisible:true];
        [extraHits setVisible:true];
        invisibleMode = false;
        }
    }
}

-(void)setToPlayerBlock
{
    blockType = blockPlayer;
}

-(void)setInvisibleMode:(float)_xInvisibleModeScreenPosition
{
    invisibleMode = true;
    xInvisibleModeScreenPosition = _xInvisibleModeScreenPosition;
    [sprite setVisible:false];
    [extraHits setVisible:false];
}

-(void)decrementLife
{
    life--;
    [self loadLifeSpriteCounter];
}

-(int)getLife
{
    return life;
}

-(int)rowPosition
{
    float pos = screenPosition.y;
    if (pos < kGameBlockSizeRadius)
        return 0;
    
    pos -= kGameBlockSize;
    if (pos < kGameBlockSizeRadius)
        return 1;
    
    pos -= kGameBlockSize;
    if (pos < kGameBlockSizeRadius)
        return 2;
    
    pos -= kGameBlockSize;
    if (pos < kGameBlockSizeRadius)
        return 3;
    
    pos -= kGameBlockSize;
    if (pos < kGameBlockSizeRadius)
        return 4;
    
    return 5;
}

-(bool)isRowPosition:(int)rowPosition
{
    float pos = screenPosition.y;
    if (pos < kGameBlockSizeRadius) {
        if (rowPosition == 0)
            return true;
        else
            return false;
    }
    
    pos -= kGameBlockSize;
    if (pos < kGameBlockSizeRadius) {
        if (rowPosition == 1)
            return true;
        else
            return false;
    }
    
    pos -= kGameBlockSize;
    if (pos < kGameBlockSizeRadius) {
        if (rowPosition == 2)
            return true;
        else
            return false;
    }
    
    pos -= kGameBlockSize;
    if (pos < kGameBlockSizeRadius) {
        if (rowPosition == 3)
            return true;
        else
            return false;
    }
    
    
    pos -= kGameBlockSize;
    if (pos < kGameBlockSizeRadius) {
        if (rowPosition == 4)
            return true;
        else
            return false;
    }
    
    
    pos -= kGameBlockSize;
    if (pos < kGameBlockSizeRadius) {
        if (rowPosition == 5)
            return true;
        else
            return false;
    }
    
    
    return false;
}

-(void) dealloc
{
    [[InGameSpriteManager shared] removeInGameSprite:sprite];
    
    if (extraHits)
        [[InGameSpriteManager shared] removeInGameSprite:extraHits];
    
//    [sprite removeFromParentAndCleanup:true];
    sprite = nil;
    extraHits = nil;
  //  [super dealloc];
}

@end
