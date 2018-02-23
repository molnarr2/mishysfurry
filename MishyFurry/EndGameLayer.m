//
//  EndGameLayer.m
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/21/12.
//
//

#import "EndGameLayer.h"

@implementation EndGameLayer

// This method is called right after the class has been instantiated
// by CCBReader. Do any additional initiation here. If no extra
// initialization is needed, leave this method out.
- (void) didLoadFromCCB
{

}

-(void)pressedNewGame:(id)sender
{
    [[SceneManager shared] startNewGame];
}

-(void)pressedExit:(id)sender
{
    [[SceneManager shared] startMainMenu:true];
}

#pragma mark EndGameLayerProtocol

-(void)setScore:(int)scoreValue
{
    CCLabelTTF *score = (CCLabelTTF *)[self getChildByTag:100];
    NSString *string = [NSString stringWithFormat:@"%d", scoreValue];
    [score setString:string];
}

@end
