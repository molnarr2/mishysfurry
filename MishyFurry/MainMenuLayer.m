//
//  MainMenuLayer.m
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/12/12.
//
//

#import "MainMenuLayer.h"

@implementation MainMenuLayer

-(id)init
{
    if( (self=[super init])) {
        director_ = (CCDirectorIOS*) [CCDirector sharedDirector];
    }
    return self;
}

-(void) pressedArcade:(id)sender
{
    [[SceneManager shared] startNewArcadeGame];
}

-(void) pressedFrenzy:(id)sender
{
    [[SceneManager shared] startNewFrenzyGame];
}

-(void) pressedInsane:(id)sender
{
    [[SceneManager shared] startNewInsaneGame];
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
    
    NSLog(@"MainMenuLayer::Dealloc");
    
	// don't forget to call "super dealloc"
    //	[super dealloc];
}
@end
