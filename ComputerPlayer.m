//
//  ComputerPlayer.m
//  MishyFurry
//
//  Created by Robert Molnar 2 on 12/7/12.
//
//

#import "ComputerPlayer.h"

@implementation ComputerPlayer

@synthesize ingame;

-(id) initComputerPlayer: (enum computerPlayerType)_computerPlayerType
{
    if( (self=[super init])) {
        computerPlayerType = _computerPlayerType;
        int gridHeight = (int)ceil((float)kDeviceHeight / (float)kGameBlockSize);
        incomingBlockGridSize = gridHeight - 2;
        
        currentPattern = nil;
        
        randomThousand = arc4random() % 1001;
        
        [ingame setVelocityTo:5];
    }
    return self;
}

-(void) buildNextBlockColumn: (float)_xAbsolutePos blockDistance: (int)_blockDistance;
{
    xAbsolutePos = _xAbsolutePos;
    blockDistance = _blockDistance;
    
    [self computerTime];
}

-(void) computerTime
{
    if (blockDistance > 250)
        difficulty = difficultyExtreme;
    else if (blockDistance > 70)
        difficulty = difficultyVeryHard;
    else if (blockDistance > 40)
        difficulty = difficultyHard;
    else if (blockDistance > 30)
        difficulty = difficultyMedium;
    else if (blockDistance > 20)
        difficulty = difficultyNormal;
    else
        difficulty = difficultyEasy;
    
    // First time always start with StartPattern.
    if (currentPattern == nil) {
        currentPattern = [[StartPattern alloc] init];
        [currentPattern setGameNextStripProtocol:ingame];
        [currentPattern setDifficulty:difficulty];
    }
    
    // Process the current pattern. This will create the next column's data.
    if (![currentPattern nextColumn])
        return;

    // Time for a new pattern.
    [currentPattern setGameNextStripProtocol:nil];
    if (computerPlayerType == insaneComputer)
        currentPattern = [self newInsanePattern];
    else if (computerPlayerType == arcadeComputer)
        currentPattern = [self newArcadePattern];
    else if (computerPlayerType == frenzyComputer)
        currentPattern = [self newFrenzyPattern];
    
    // Set up the new pattern.
    [currentPattern setGameNextStripProtocol:ingame];
    [currentPattern setDifficulty:difficulty];
}

-(id<AIPatternProtocol>) newArcadePattern
{    
    return [[Dunlop4Pattern alloc] init];
}

-(id<AIPatternProtocol>) newFrenzyPattern
{
    int rand = arc4random_uniform(1000) % 17;
    
    if (rand == 0)
        return [[Easy1Pattern alloc] init];
    
    if (rand == 1)
        return [[Easy2Pattern alloc] init];
    
    if (rand == 2)
        return [[Easy3Pattern alloc] init];
    
    if (rand == 3)
        return [[SquarePattern alloc] init];
    
    if (rand == 4)
        return [[EasySequence1Pattern alloc] init];
    
    if (rand == 5)
        return [[VPattern alloc] init]; // TODO - XPattern
    
    if (rand == 6)
        return [[VPattern alloc] init];
    
    if (rand == 7)
        return [[CakePattern alloc] init];
    
    if (rand == 8)
        return [[TouchInsane1Pattern alloc] init];
    
    if (rand == 9)
        return [[TouchInsane2Pattern alloc] init];
    
    if (rand == 10)
        return [[Touch1Pattern alloc] init];
    
    if (rand == 11)
        return [[TitleistPattern alloc] init];
    
    if (rand == 12)
        return [[TopFlightPattern alloc] init];
    
    if (rand == 13)
        return [[DunlopPattern alloc] init];
    
    if (rand == 14)
        return [[Dunlop2Pattern alloc] init];
    
    if (rand == 15)
        return [[Dunlop4Pattern alloc] init];
    
    return [[PopupCrazyPattern alloc] init];
}

-(id<AIPatternProtocol>) newInsanePattern
{
    return [[PopupCrazyPattern alloc] init];
    
//    return [[EasySequence1Pattern alloc] init];
}

@end
