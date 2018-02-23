//
//  InGameSpriteManager.h
//  Mishy's Furry
//
//  Created by Robert Molnar 2 on 11/1/12.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameConfiguration.h"


#define kInGameGraphicsPlist @"ingame.plist"

#define kRedBlock @"RedBlock.png"
#define kTealBlock @"TealBlock.png"
#define kPurpleBlock @"PurpleBlock.png"
#define kBlueBlock @"BlueBlock.png"
#define kYellowBlock @"YellowBlock.png"
#define kGreenBlock @"GreenBlock.png"
#define kHeart @"Heart.png"
#define kBlackBlock @"TapBlock.png"
#define kX2 @"x2.png"
#define kX3 @"x3.png"
#define kPowerBlock @"PowerBlock.png"
#define kOrangeBlock @"OrangeBlock.png"
#define kSpike @"spike.png"
#define kLightening @"lightening.png"

@interface InGameSpriteManager : NSObject {
    CCSpriteBatchNode *inGameBatchNode;
    CCLayer *inGameLayer;
}

@property(nonatomic) CCLayer *inGameLayer;

+(InGameSpriteManager *)shared;

-(void) loadInGameGraphics;
-(void) releaseInGameGraphics;
-(void) attachInGameGraphics: (CCLayer *)layer;
-(void) deattachInGameGraphics: (CCLayer *)layer;

/** This will get an ingame sprite frame. Make sure to use the constants from this class.
 * This will attach the sprite to the inGameBatchNode.
 * @param spriteFrameName is the name of the sprite from the kInGameGraphicsPList file.
 */
-(CCSprite *) newInGameSprite: (NSString *)spriteFrameName;

-(void) removeInGameSprite: (CCSprite *)sprite;

@end
