//
//  AIPatternSundry.m
//  MishyFurry
//
//  Created by Robert Molnar 2 on 1/8/13.
//
//

#import "AIPatternSundry.h"

/*
 
 int thePlayingField[kGameFieldSize][k10Pattern] =
{{0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0}};
 
 */

@implementation StartPattern

-(bool)_nextColumn
{
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:smashableGreenBlock bottomCell:smashableGreenBlock];
    
    if (blockCount >= kStartingFieldBlockCount)
        return true;
    return false;
}

@end

@implementation Easy1Pattern

-(bool)_nextColumn
{
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:smashableRedBlock bottomCell:smashablePurpleBlock];
    
    [ingame addIncomingSmashable:smashableRedBlock incomingGridPos:0];
    
    if (blockCount >= 50)
        return true;
    return false;
}

@end

@implementation Easy2Pattern

-(bool)_nextColumn
{
    topBlock = smashableBlueBlock;
    bottomBlock = smashableYellowBlock;
    
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:topBlock bottomCell:bottomBlock];
    
    enum smashableBlockType incomingBlock = topBlock;
    if (arc4random_uniform(100) % 50 > 80)
        incomingBlock = bottomBlock;
    
    //    int randomPosition = arc4random_uniform(kIncomingFieldSize-1);
    [ingame addIncomingSmashable:incomingBlock incomingGridPos:3];
    
    if (blockCount >= 50)
        return true;
    return false;
}

@end

@implementation Easy3Pattern

-(bool)_nextColumn
{
    topBlock = smashableBlueBlock;
    bottomBlock = smashableYellowBlock;
    
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:topBlock bottomCell:bottomBlock];
    
    enum smashableBlockType incomingBlock = topBlock;
    if (arc4random_uniform(100) > 80)
        incomingBlock = bottomBlock;
    
    if (arc4random_uniform(100) > 50) {
        int randomPosition = arc4random_uniform(kIncomingFieldSize-1);
        [ingame addIncomingSmashable:incomingBlock incomingGridPos:randomPosition];
    }
    
    if (blockCount >= 25)
        return true;
    return false;
}

@end

/* ------------------------------------------------------------------------------------------------
 * ------------------------------------------------------------------------------------------------
 * -- SquarePattern --
 */

@implementation SquarePattern

-(void)setDifficulty:(enum aiPatternDifficulty)_difficulty
{
    [super setDifficulty:_difficulty];
    
    int thePlayingField[kGameFieldSize][8] =
       {{a, a, a, a, a, a, a, a},
        {a, a, 0, 0, 0, 0, 0, 0},
        {a, a, 0, 0, 0, 0, 0, 0},
        {0, 0, 0, 0, b, b, 0, 0},
        {0, 0, 0, 0, b, b, 0, 0},
        {b, b, b, b, b, b, b, b}};
    
    [self setupPattern:(int *)thePlayingField length:8];
}

-(bool)_nextColumn
{
    return [self playPattern];
}

@end

@implementation EasySequence1Pattern

-(void)setDifficulty:(enum aiPatternDifficulty)_difficulty
{
    [super setDifficulty:_difficulty];
    
    int thePlayingField[kGameFieldSize][k12Pattern] =
       {{a, a, b, b, c, c, d, d, a, a, b, b},
        {a, a, 0, 0, d, c, 0, 0, a, a, 0, 0},
        {a, a, 0, 0, d, c, 0, 0, b, b, 0, 0},
        {0, 0, c, c, 0, 0, d, a, 0, 0, b, b},
        {0, 0, c, c, 0, 0, d, a, 0, 0, c, c},
        {b, b, c, c, d, d, a, a, b, b, c, c}};
    
    [self setupPattern:(int *)thePlayingField length:k12Pattern];
}

-(bool)_nextColumn
{
    return [self playPattern];
}

@end


@implementation VPattern

-(void)setDifficulty:(enum aiPatternDifficulty)_difficulty
{
    [super setDifficulty:_difficulty];
    
    int thePlayingField[kGameFieldSize][k9Pattern] =
    {   {b, b, b, b, b, b, b, b, b},
        {a, b, b, b, b, b, b, a, 0},
        {0, a, b, b, b, b, a, 0, 0},
        {0, 0, a, b, b, a, 0, 0, 0},
        {0, 0, 0, a, a, 0, 0, 0, 0},
        {a, a, a, a, a, a, a, a, a}};
    
    [self setupPattern:(int *)thePlayingField length:k9Pattern];
}

-(bool)_nextColumn
{
    return [self playPattern];
}

@end


@implementation CakePattern

-(void)setDifficulty:(enum aiPatternDifficulty)_difficulty
{
    [super setDifficulty:_difficulty];
    
    int thePlayingField[kGameFieldSize][k10Pattern] =
    {   {a, b, c, d, e, f, g, a, b, c},
        {0, T, 0, T, 0, T, 0, T, 0, T},
        {0, R, 0, 0, 0, 0, 0, 0, 0, R},
        {0, 0, 0, R, 0, 0, 0, R, 0, 0},
        {0, T, 0, T, 0, T, 0, T, 0, T},
        {b, c, d, e, f, g, a, b, c, d}};
    
    [self setupPattern:(int *)thePlayingField length:k10Pattern];
}

-(bool)_nextColumn
{
    return [self playPattern];
}

@end


@implementation TouchInsane1Pattern

-(void)setDifficulty:(enum aiPatternDifficulty)_difficulty
{
    [super setDifficulty:_difficulty];
    
    int X = a;
    if (arc4random_uniform(100) > 50)
        X = b;
    
    int Y = a;
    if (arc4random_uniform(100) > 50)
        Y = b;
    
    int H = 0;
    if (difficulty >= difficultyHard)
        H = T;
    
    int thePlayingField[kGameFieldSize][k10Pattern] =
    {   {a, a, a, a, a, a, a, a, a, a},
        {H, H, H, H, H, H, H, T, T, 0},
        {H, H, H, H, T, T, T, X, Y, 0},
        {H, T, T, T, Y, a, b, X, Y, 0},
        {T, X, Y, X, Y, a, b, X, Y, 0},
        {b, b, b, b, b, b, b, b, b, b}};
    
    [self setupPattern:(int *)thePlayingField length:k10Pattern];
}

-(bool)_nextColumn
{
    return [self playPattern];
}

@end

@implementation TouchInsane2Pattern

-(void)setDifficulty:(enum aiPatternDifficulty)_difficulty
{
    [super setDifficulty:_difficulty];
    
    int X = a;
    if (arc4random_uniform(100) > 50)
        X = b;
    
    int Y = a;
    if (arc4random_uniform(100) > 50)
        Y = b;
    
    
    int thePlayingField[kGameFieldSize][k10Pattern] =
    {   {a, a, a, a, a, a, a, a, a, a},
        {T, 0, 0, 0, 0, 0, 0, T, T, 0},
        {T, 0, 0, 0, T, T, T, X, Y, 0},
        {T, T, T, T, Y, a, b, X, Y, 0},
        {T, X, Y, X, Y, a, b, X, Y, 0},
        {b, b, b, b, b, b, b, b, b, b}};
    
    [self setupPattern:(int *)thePlayingField length:k10Pattern];
}

-(bool)_nextColumn
{
    return [self playPattern];
}

@end

@implementation Wall1Pattern

-(void)setDifficulty:(enum aiPatternDifficulty)_difficulty
{
    [super setDifficulty:_difficulty];
    
    
    int X = a;
    if (arc4random_uniform(100) > 50)
        X = b;
    
    int A = a;
    int C = 0;
    int D = 0;
    if (difficulty >= difficultyNormal)
        C = c + 1;
    if (difficulty >= difficultyHard) {
        D = c + 2;
        A = a + 1;
    }
    
    int thePlayingField[kGameFieldSize][k10Pattern] =
    {   {b, c, a, d, b, c, a, e, a, c},
        {0, 0, 0, 0, 0, 0, a, 0, 0, 0},
        {0, 0, 0, 0, A, 0, a, 0, 0, 0},
        {0, 0, a, 0, A, 0, a, 0, a, 0},
        {a, C, a, 0, a, D, a, 0, a, C},
        {a, b, c, c, a, e, f, c, a, b}};
    
    [self setupPattern:(int *)thePlayingField length:k10Pattern];
}

-(bool)_nextColumn
{
    return [self playPattern];
}

@end

@implementation Touch1Pattern

-(void)setDifficulty:(enum aiPatternDifficulty)_difficulty
{
    [super setDifficulty:_difficulty];
    
    int A = a;
    int Z = 0;
    int Y = 0;
    if (difficulty >= difficultyNormal)
        A = a + 1;
    if (difficulty >= difficultyHard) {
        A = a + 2;
    }
    if (difficulty >= difficultyVeryHard) {
        Z = T;
    }
    if (difficulty >= difficultyExtreme) {
        Y = T;
    }
    
    int thePlayingField[kGameFieldSize][k12Pattern] =
    {{b, a, c, d, e, f, g, a, b, c, d, f},
        {T, T, T, Z, Z, Z, Z, Z, T, T, T, 0},
        {T, A, T, Y, T, T, T, Y, T, A, T, 0},
        {T, T, T, Y, T, A, T, Y, T, T, T, 0},
        {Z, Z, Z, Z, T, T, T, Z, Z, Z, Z, 0},
        {b, b, b, a, a, a, f, f, f, a, a, a}};
    
    [self setupPattern:(int *)thePlayingField length:k12Pattern];
}

-(bool)_nextColumn
{
    return [self playPattern];
}

@end

@implementation TitleistPattern

-(bool)_nextColumn
{
    int A = a;
    int B = b;
    
    // Set up the type of block to play with.
    switch (difficulty) {
        case difficultyEasy:
            break;
        case difficultyNormal:
            break;
        case difficultyMedium:
            break;
        case difficultyHard:
        case difficultyVeryHard:
        case difficultyExtreme:
        default:
            A = [self getSmashBlock:1];
            B = [self getSmashBlockExclude:A lifeCount:1];
            break;
    }
    
    // Build the background blocks.
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:A bottomCell:B];
    
    // Incoming blocks.
    if (arc4random_uniform(100) > 40) {
        switch (difficulty) {
            case difficultyEasy:
            case difficultyNormal:
            case difficultyMedium:
                [self randomDouble:A block2:B];
                break;
            case difficultyHard:
            case difficultyVeryHard:
                [self randomDouble:[self smashableBlockUpgradeWithLife:A lifeCount:2] block2:[self smashableBlockUpgradeWithLife:B lifeCount:2]];
                break;
            case difficultyExtreme:
                [self randomDouble:[self smashableBlockUpgradeWithLife:A lifeCount:3] block2:[self smashableBlockUpgradeWithLife:B lifeCount:3]];
            default:
                break;
        }
    }
    
    if (blockCount >= 20)
        return true;
    return false;
}

@end

@implementation TopFlightPattern

-(bool)_nextColumn
{
    int A = a;
    int B = b;
    
    // Set up the type of block to play with.
    switch (difficulty) {
        case difficultyEasy:
            break;
        case difficultyNormal:
            break;
        case difficultyMedium:
            break;
        case difficultyHard:
        case difficultyVeryHard:
        case difficultyExtreme:
        default:
            A = [self getSmashBlock:1];
            B = [self getSmashBlockExclude:A lifeCount:1];
            break;
    }
    
    // Build the background blocks.
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:A bottomCell:B];
    
    // Incoming blocks.
    if (arc4random_uniform(100) > 50) {
        switch (difficulty) {
            case difficultyEasy:
            case difficultyNormal:
            case difficultyMedium:
                [self randomSingle:A block2:B];
                break;
            case difficultyHard:
            case difficultyVeryHard:
                [self randomSingle:[self smashableBlockUpgradeWithLife:A lifeCount:2] block2:[self smashableBlockUpgradeWithLife:B lifeCount:2]];
                break;
            case difficultyExtreme:
                [self randomSingle:[self smashableBlockUpgradeWithLife:A lifeCount:3] block2:[self smashableBlockUpgradeWithLife:B lifeCount:3]];
            default:
                break;
        }
    }
    
    if (blockCount >= 20)
        return true;
    return false;
}

@end

@implementation DunlopPattern

-(bool)_nextColumn
{
    // Set up the type of block to play with.
    int A = a;
    int B = b;
    if ((blockCount % 6) > 2) {
        A = b;
        B = a;
    }
    
    // Build the background blocks.
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:A bottomCell:B];
    
    // Incoming blocks.
    int block = a;
    if ((blockCount % 4) > 1) {
        block = b;
    }
    
    switch (difficulty) {
        case difficultyEasy:
        case difficultyNormal:
        case difficultyMedium:
            [self randomDouble:block block2:block];
            break;
        case difficultyHard:
        case difficultyVeryHard:
            [self randomDouble:[self smashableBlockUpgradeWithLife:block lifeCount:2] block2:[self smashableBlockUpgradeWithLife:block lifeCount:2]];
            break;
        case difficultyExtreme:
            [self randomDouble:[self smashableBlockUpgradeWithLife:block lifeCount:3] block2:[self smashableBlockUpgradeWithLife:block lifeCount:3]];
        default:
            break;
    }
    
    if (blockCount >= 20)
        return true;
    return false;
}

@end

@implementation Dunlop2Pattern

-(bool)_nextColumn
{
    // Set up the type of block to play with.
    int A = a;
    int B = b;
    if ((blockCount % 6) > 2) {
        A = b;
        B = a;
    }
    
    // Build the background blocks.
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:A bottomCell:B];
    
    // Incoming blocks.
    int block = a;
    if ((blockCount % 4) > 1) {
        block = b;
    }
    
    switch (difficulty) {
        case difficultyEasy:
        case difficultyNormal:
        case difficultyMedium:
            [self randomDouble:block block2:touchableBlock];
            break;
        case difficultyHard:
        case difficultyVeryHard:
            [self randomDouble:[self smashableBlockUpgradeWithLife:block lifeCount:2] block2:touchableBlock];
            break;
        case difficultyExtreme:
            [self randomDouble:[self smashableBlockUpgradeWithLife:block lifeCount:3] block2:touchableBlock];
        default:
            break;
    }
    
    if (blockCount >= 20)
        return true;
    return false;
}

@end


@implementation Dunlop3Pattern

-(bool)_nextColumn
{
    // Set up the type of block to play with.
    int A = a;
    int B = b;
    if ((blockCount % 6) > 2) {
        A = b;
        B = a;
    }
    
    // Build the background blocks.
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:A bottomCell:B];
    
    // Incoming blocks.
    int block = a;
    if ((blockCount % 2) == 1) {
        block = touchableBlock;
    }
    
    switch (difficulty) {
        case difficultyEasy:
        case difficultyNormal:
        case difficultyMedium:
            [self randomSingle:block];
            break;
        case difficultyHard:
        case difficultyVeryHard:
            [self randomSingle:block];
            break;
        case difficultyExtreme:
            [self randomSingle:block];
        default:
            break;
    }
    
    if (blockCount >= 20)
        return true;
    return false;
}

@end

@implementation Dunlop4Pattern

-(bool)_nextColumn
{
    // Set up the type of block to play with.
    int A = a;
    int B = b;
    if ((blockCount % 6) > 2) {
        A = b;
        B = a;
    }
    
    // Build the background blocks.
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:A bottomCell:B];
    
    switch (difficulty) {
        case difficultyEasy:
        case difficultyNormal:
        case difficultyMedium:
            [self randomSingleTochable:a];
            break;
        case difficultyHard:
        case difficultyVeryHard:
            [self randomSingleTochable:[self smashableBlockUpgradeWithLife:a lifeCount:2]];
            break;
        case difficultyExtreme:
            [self randomSingleTochable:[self smashableBlockUpgradeWithLife:a lifeCount:3]];
        default:
            break;
    }
    
    if (blockCount >= 20)
        return true;
    return false;
}

@end

@implementation PopupCrazyPattern

-(bool)_nextColumn
{
    // Set up the type of block to play with.
    int A = a;
    int B = b;
    if ((blockCount % 6) > 2) {
        A = b;
        B = a;
    }
    
    // Build the background blocks.
    [ingame buildBackgroundBlocks: [self getBackgroundBlock] topCell:A bottomCell:B];
    
    switch (difficulty) {
        case difficultyEasy:
        case difficultyNormal:
        case difficultyMedium:
            [self randomSingleInvisible:a];
            break;
        case difficultyHard:
        case difficultyVeryHard:
            [self randomSingleInvisible:[self smashableBlockUpgradeWithLife:a lifeCount:2]];
            break;
        case difficultyExtreme:
            [self randomSingleInvisible:[self smashableBlockUpgradeWithLife:a lifeCount:3]];
        default:
            break;
    }
    
    if (blockCount >= 20)
        return true;
    return false;
}

@end



