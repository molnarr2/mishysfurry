//
//  AIPattern.m
//  MishyFurry
//
//  Created by Robert Molnar 2 on 12/11/12.
//
//

#import "AIPattern.h"


/* ------------------------------------------------------------------------------------------------------------------------------------------
 * ------------------------------------------------------------------------------------------------------------------------------------------
 * -- AIPattern --
 */

@implementation AIPattern

-(enum smashableBlockType) getSmashBlock:(int)lifeCount
{
    int number = arc4random_uniform(1000);
    
    if (difficulty == difficultyEasy) {
        if (number < 500)
            return [self smashableBlockUpgradeWithLife:smashableBlueBlock lifeCount:lifeCount];
        else
            return [self smashableBlockUpgradeWithLife:smashableYellowBlock lifeCount:lifeCount];
    } else if (difficulty == difficultyNormal) {
        if (number < 300)
            return [self smashableBlockUpgradeWithLife:smashableYellowBlock lifeCount:lifeCount];
        else if (number < 600)
            return [self smashableBlockUpgradeWithLife:smashableGreenBlock lifeCount:lifeCount];
        else
            return [self smashableBlockUpgradeWithLife:smashableOrangeBlock lifeCount:lifeCount];
        
    } else if (difficulty == difficultyMedium) {
        if (number < 250)
            return [self smashableBlockUpgradeWithLife:smashableOrangeBlock lifeCount:lifeCount];
        else if (number < 500)
            return [self smashableBlockUpgradeWithLife:smashableGreenBlock lifeCount:lifeCount];
        else if (number < 750)
            return [self smashableBlockUpgradeWithLife:smashablePurpleBlock lifeCount:lifeCount];
        else
            return [self smashableBlockUpgradeWithLife:smashableYellowBlock lifeCount:lifeCount];
        
    } else if (difficulty == difficultyHard) {
        if (number < 250)
            return [self smashableBlockUpgradeWithLife:smashableOrangeBlock lifeCount:lifeCount];
        else if (number < 500)
            return [self smashableBlockUpgradeWithLife:smashableGreenBlock lifeCount:lifeCount];
        else if (number < 750)
            return [self smashableBlockUpgradeWithLife:smashablePurpleBlock lifeCount:lifeCount];
        else
            return [self smashableBlockUpgradeWithLife:smashableRedBlock lifeCount:lifeCount];
        
    } else if (difficulty == difficultyVeryHard) {
        if (number < 200)
            return [self smashableBlockUpgradeWithLife:smashableYellowBlock lifeCount:lifeCount];
        else if (number < 400)
            return [self smashableBlockUpgradeWithLife:smashableGreenBlock lifeCount:lifeCount];
        else if (number < 600)
            return [self smashableBlockUpgradeWithLife:smashablePurpleBlock lifeCount:lifeCount];
        else if (number < 800)
            return [self smashableBlockUpgradeWithLife:smashableBlueBlock lifeCount:lifeCount];
        else
            return [self smashableBlockUpgradeWithLife:smashableRedBlock lifeCount:lifeCount];
        
    } else { // Extreme
        if (number < 150)
            return [self smashableBlockUpgradeWithLife:smashableYellowBlock lifeCount:lifeCount];
        else if (number < 300)
            return [self smashableBlockUpgradeWithLife:smashableGreenBlock lifeCount:lifeCount];
        else if (number < 450)
            return [self smashableBlockUpgradeWithLife:smashablePurpleBlock lifeCount:lifeCount];
        else if (number < 600)
            return [self smashableBlockUpgradeWithLife:smashableBlueBlock lifeCount:lifeCount];
        else if (number < 750)
            return [self smashableBlockUpgradeWithLife:smashableOrangeBlock lifeCount:lifeCount];
        else
            return [self smashableBlockUpgradeWithLife:smashableTealBlock lifeCount:lifeCount];
    }
}

-(enum smashableBlockType) getSmashBlockExclude:(enum smashableBlockType)exclude lifeCount:(int)lifeCount
{
    while(true) {
        enum smashableBlockType block = [self getSmashBlock:lifeCount];
        if (![self blocksMatch:block block2:exclude])
            return block;
    }
}

-(enum smashableBlockType) smashableBlockUpgradeWithLife:(enum smashableBlockType)smashBlock lifeCount:(int)lifeCount
{
    if (smashBlock == smashableBlueBlock) {
        if (lifeCount == 1)
            return smashableBlueBlock;
        else if (lifeCount == 2)
            return smashableBlueBlockX2;
        else if (lifeCount == 3)
            return smashableBlueBlockX3;
    } else if (smashBlock == smashableYellowBlock) {
        if (lifeCount == 1)
            return smashableYellowBlock;
        else if (lifeCount == 2)
            return smashableYellowBlockX2;
        else if (lifeCount == 3)
            return smashableYellowBlockX3;
    } else if (smashBlock == smashableGreenBlock) {
        if (lifeCount == 1)
            return smashableGreenBlock;
        else if (lifeCount == 2)
            return smashableGreenBlockX2;
        else if (lifeCount == 3)
            return smashableGreenBlockX3;
    } else if (smashBlock == smashableRedBlock) {
        if (lifeCount == 1)
            return smashableRedBlock;
        else if (lifeCount == 2)
            return smashableRedBlockX2;
        else if (lifeCount == 3)
            return smashableRedBlockX3;
    } else if (smashBlock == smashableTealBlock) {
        if (lifeCount == 1)
            return smashableTealBlock;
        else if (lifeCount == 2)
            return smashableTealBlockX2;
        else if (lifeCount == 3)
            return smashableTealBlockX3;
    } else if (smashBlock == smashablePurpleBlock) {
        if (lifeCount == 1)
            return smashablePurpleBlock;
        else if (lifeCount == 2)
            return smashablePurpleBlockX2;
        else if (lifeCount == 3)
            return smashablePurpleBlockX3;
    } else if (smashBlock == smashableOrangeBlock) {
        if (lifeCount == 1)
            return smashableOrangeBlock;
        else if (lifeCount == 2)
            return smashableOrangeBlockX2;
        else
            return smashableOrangeBlockX3;
    }
    
    return smashableYellowBlock;
}

-(bool)blocksMatch:(enum smashableBlockType)block1 block2:(enum smashableBlockType)block2
{
    int mod = block1 % 3;
    if (mod == 2)
        block1--;
    if (mod == 0)
        block1 -= 2;
    
    mod = block2 % 3;
    if (mod == 2)
        block2--;
    if (mod == 0)
        block2 -= 2;
    
    if ((block1 - block2) == 0)
        return true;
    return false;
}

-(enum backgroundColorType) getBackgroundBlock
{
    if (difficulty == difficultyEasy) {
        return backgroundGreen;

    } else if (difficulty == difficultyNormal) {
        return backgroundPurple;
        
    } else if (difficulty == difficultyMedium) {
        return backgroundBlue;
        
    } else if (difficulty == difficultyHard) {
        return backgroundYellow;
        
    } else if (difficulty == difficultyVeryHard) {
        return backgroundOrange;
        
    } else { // Extreme
        return backgroundRed;
    }
}

#pragma mark Subclasses must implement

-(bool)_nextColumn
{
    return true;
}

#pragma mark AIPatternProtocol

-(bool)nextColumn
{
    bool bReturn = [self _nextColumn];
    blockCount++;
    return bReturn;
}

-(void)setGameNextStripProtocol:(id<GameNextStripProtocol>)_inGame
{
    ingame = _inGame;
}


-(void)setDifficulty:(enum aiPatternDifficulty)_difficulty
{
    difficulty = _difficulty;
    
    [self setupSmashables];
}

-(void)setupSmashables
{
    int arr[7];
    
    if (difficulty == difficultyEasy) {
        arr[0] = smashableBlueBlock;
        arr[1] = smashableYellowBlock;
        arr[2] = smashableBlueBlock;
        arr[3] = smashableYellowBlock;
        arr[4] = smashableBlueBlock;
        arr[5] = smashableYellowBlock;
        arr[6] = smashableBlueBlock;
    } else if (difficulty == difficultyNormal) {
        arr[0] = smashableYellowBlock;
        arr[1] = smashableGreenBlock;
        arr[2] = smashableOrangeBlock;
        arr[3] = smashableOrangeBlock;
        arr[4] = smashableGreenBlock;
        arr[5] = smashableYellowBlock;
        arr[6] = smashableYellowBlock;
    } else if (difficulty == difficultyMedium) {
        arr[0] = smashableOrangeBlock;
        arr[1] = smashableGreenBlock;
        arr[2] = smashablePurpleBlock;
        arr[3] = smashableYellowBlock;
        arr[4] = smashableOrangeBlock;
        arr[5] = smashableGreenBlock;
        arr[6] = smashablePurpleBlock;
    } else if (difficulty == difficultyHard) {
        arr[0] = smashableOrangeBlock;
        arr[1] = smashableGreenBlock;
        arr[2] = smashablePurpleBlock;
        arr[3] = smashableRedBlock;
        arr[4] = smashableOrangeBlock;
        arr[5] = smashableGreenBlock;
        arr[6] = smashablePurpleBlock;
    } else if (difficulty == difficultyVeryHard) {
        arr[0] = smashableYellowBlock;
        arr[1] = smashableGreenBlock;
        arr[2] = smashablePurpleBlock;
        arr[3] = smashableRedBlock;
        arr[4] = smashableBlueBlock;
        arr[5] = smashableGreenBlock;
        arr[6] = smashablePurpleBlock;
    
    } else { // Extreme
        arr[0] = smashableYellowBlock;
        arr[1] = smashableGreenBlock;
        arr[2] = smashablePurpleBlock;
        arr[3] = smashableOrangeBlock;
        arr[4] = smashableBlueBlock;
        arr[5] = smashableTealBlock;
        arr[6] = smashableTealBlock;
    }

    // Randomize values.
    for (int i=0; i < 30; i++) {
        int s1 = arc4random_uniform(7);
        int s2 = arc4random_uniform(7);
        int tmp = arr[s1];
        arr[s1] = arr[s2];
        arr[s2] = tmp;
    }

    // Make sure the first four values are swapped to keep different colors one after the other.
    for (int i=0; i < 4; i++) {
        if (arr[i] == arr[i+1]) {
            for (int j=i+2; j < 7; j++) {
                if (arr[i] != arr[j]) {
                    int tmp = arr[i+1];
                    arr[i+1] = arr[j];
                    arr[j] = tmp;
                }
            }
        }
    }
    
    a = arr[0];
    b = arr[1];
    c = arr[2];
    d = arr[3];
    e = arr[4];
    f = arr[5];
    g = arr[6];
    T = touchableBlock; // Touchable
    R = 52000; // Value for a random top/bottom.
}


#pragma mark Pattern playback system.

-(void)setupPattern:(int *)patternSetup length:(int)length
{    
    patternLength = length;
    patternPosition = 0;
    
    patternPlayBack = (int **)malloc((kGameFieldSize) * sizeof(int *));
    
    for (int y=0; y < kGameFieldSize; y++) {
        patternPlayBack[y] = (int *)malloc(patternLength * sizeof(int));
        for (int x=0; x < patternLength; x++) {
            int offset = x + y * length;
            int value = patternSetup[offset];
            
            // Random smashblock.
            if (value == R) {
                if ((arc4random() * 100) % 100 > 50)
                    value = patternSetup[x];
                else
                    value = patternSetup[x + length * 5];
            }
            
            patternPlayBack[y][x] = value;
        }
    }
}

-(bool)playPattern
{
    // Safeguard against array run over.
    if (patternPosition >= patternLength)
        return true;
    
    // Set up the top block and the background.
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:patternPlayBack[0][patternPosition] bottomCell:patternPlayBack[kGameFieldSize-1][patternPosition]];
    
    // Set up the incoming blocks.
    for (int y=0; y < kIncomingFieldSize; y++) {
        [ingame addIncomingSmashable:patternPlayBack[y+1][patternPosition] incomingGridPos:y];
    }
    
    // Next block.
    patternPosition++;
    
    // Pattern done?
    if (patternPosition >= patternLength)
        return true;
    return false;
}

-(bool)isPatternDone
{
    if (patternPosition >= patternLength)
        return true;
    return false;
}

-(void)dealloc
{
    if (patternLength) {
        patternLength = 0;
        for (int y=0; y < kGameFieldSize; y++)
            free (patternPlayBack[y]);
        free (patternPlayBack);
        patternPlayBack = NULL;
    }
}

// ----------------------------------

-(void) randomSingle: (enum smashableBlockType)block
{
    int rand = arc4random_uniform(100) % 4;
    [ingame addIncomingSmashable:block incomingGridPos:rand];
}

-(void) randomSingle: (enum smashableBlockType)block1 block2:(enum smashableBlockType)block2
{
    int rand = arc4random_uniform(100) % 4;
    
    if ((arc4random_uniform(100) % 2) == 0)
        [ingame addIncomingSmashable:block1 incomingGridPos:rand];
    else
        [ingame addIncomingSmashable:block2 incomingGridPos:rand];
}

-(void) randomSingle: (enum smashableBlockType)block pos1:(int)pos1 pos2:(int)pos2
{
    int rand = arc4random_uniform(100) % 2;
    
    if (rand == 0)
        [ingame addIncomingSmashable:block incomingGridPos:pos1];
    else
        [ingame addIncomingSmashable:block incomingGridPos:pos2];
}

-(void) randomDouble: (enum smashableBlockType)block1 block2:(enum smashableBlockType)block2
{
    int rand = arc4random_uniform(100) % 3;
    int block = (arc4random_uniform(100) % 2 == 0) ? block1 : block2;
    
    [ingame addIncomingSmashable:block incomingGridPos:rand];
    [ingame addIncomingSmashable:block incomingGridPos:rand+1];
}

-(void) randomSingleTochable: (enum smashableBlockType)block
{
    int rand = arc4random_uniform(100) % 3;
    
    int block1 = block;
    int block2 = touchableBlock;
    
    if (arc4random_uniform(100) % 2 == 0) {
        block1 = touchableBlock;
        block2 = block;
    }
    
    [ingame addIncomingSmashable:block1 incomingGridPos:rand];
    [ingame addIncomingSmashable:block2 incomingGridPos:rand+1];
}

-(void) randomSingleInvisible: (enum smashableBlockType)block
{
    int rand = arc4random_uniform(100) % 4;
    [ingame addIncomingSmashableInvisible:block incomingGridPos:rand invisiblePos:850];
}


@end
