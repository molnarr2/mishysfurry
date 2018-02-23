//
//  HUDdisplay.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/6/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConfiguration.h"
#import "InGameSpriteManager.h"


@interface HUDdisplay : NSObject {
    // The player lives.
    int playerLives;
    // The player score.
    int playerScore;
    // Contains the CGSprites of the player lives.
    NSMutableArray *arrPlayerLives;
    // The score label.
    CCLabelTTF *scoreLabel;
    // The multiplier label.
    CCLabelTTF *multiplierLabel;
    // This is the score moultiplier. If player decreases a life than this is reset to one.
    int scoreMultiplier;
}

-(id)initHUDdisplay:(int)_playerLives;

-(void)buildPlayerLives;

-(int) getPlayerScore;

// Call this to decrement the number of lives the player has.
-(void)playerLosesLives:(int)playerLostLives;

// @Return true if play has lives left.
-(bool)hasPlayerLivesLeft;

// Add to the player score.
-(void)addToPlayerScore:(int)score;

// This will update the score label.
-(void)updateScoreLabel;

@end
