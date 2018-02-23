//
//  HUDdisplay.m
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/6/12.
//
//

#import "HUDdisplay.h"

@implementation HUDdisplay

-(id)initHUDdisplay:(int)_playerLives
{
    if( (self=[super init])) {
        playerLives = _playerLives;
        playerScore = 0;
        scoreMultiplier = 1;
        scoreLabel = nil;
        multiplierLabel = nil;
        [self buildPlayerLives];
        [self updateScoreLabel];
    }
    
    return self;
}

-(void)buildPlayerLives
{
    // The offset between each life.
    float offset = 30;
    // The starting position for the first life.
    float xStartingPosition = kDeviceWidth - offset;
    float yPosition = kDeviceHeight - 25;
    
    arrPlayerLives = [[NSMutableArray alloc] initWithCapacity:playerLives];
    for (int i=0; i < playerLives; i++) {
        CCSprite *sprite = [[InGameSpriteManager shared] newInGameSprite:kHeart];
        [sprite setZOrder:5000];
        [sprite setPosition:CGPointMake(xStartingPosition, yPosition)];
        [arrPlayerLives addObject:sprite];
        xStartingPosition -= offset;
    }
}


// Call this to decrement the number of lives the player has.
-(void)playerLosesLives:(int)playerLostLives
{
    playerLives -= playerLostLives;
    int count = [arrPlayerLives count];
    for (int i=0; i < count; i++) {
        if (i < playerLives)
            continue;
        CCSprite *sprite = [arrPlayerLives objectAtIndex:i];
        [sprite setVisible:false];
    }
    
    scoreMultiplier = 1;
    [self updateScoreLabel];
}

// @Return true if play has lives left.
-(bool)hasPlayerLivesLeft
{
    if (playerLives>0)
        return true;
    return false;
}

-(void)updateScoreLabel
{
    InGameSpriteManager *inGame = [InGameSpriteManager shared];
    
    // The player's score.
    if (scoreLabel != nil) {
        [inGame.inGameLayer removeChild:scoreLabel cleanup:TRUE];
        scoreLabel = nil;
    }
    
    NSString *str = [NSString stringWithFormat:@"Score: %i", playerScore];
    CGSize size = CGSizeMake(200.0, 24.0);
    
    scoreLabel = [CCLabelTTF labelWithString:str dimensions:size hAlignment:CCTextAlignmentLeft fontName:@"Marker Felt" fontSize:22];
    //  [label.color = ccc3(225, 215, 0); //Gold Color Text
     scoreLabel.position = CGPointMake(100, kDeviceHeight - 30);
    [inGame.inGameLayer addChild:scoreLabel];

    // The player's multiplier.
    if (multiplierLabel != nil) {
        [inGame.inGameLayer removeChild:multiplierLabel cleanup:TRUE];
        multiplierLabel = nil;
    }
    
    str = [NSString stringWithFormat:@"Multiplier: %i", scoreMultiplier];
    size = CGSizeMake(200.0, 24.0);
    
    multiplierLabel = [CCLabelTTF labelWithString:str dimensions:size hAlignment:CCTextAlignmentLeft fontName:@"Marker Felt" fontSize:22];
    //  [label.color = ccc3(225, 215, 0); //Gold Color Text
    multiplierLabel.position = CGPointMake(100, kDeviceHeight - 55);
    [inGame.inGameLayer addChild:multiplierLabel];
}

-(void)addToPlayerScore:(int)score
{
    if (score == 0)
        return;
    
    playerScore += score * scoreMultiplier;
    scoreMultiplier++;
    [self updateScoreLabel];
}

-(int) getPlayerScore
{
    return playerScore;
}

@end
