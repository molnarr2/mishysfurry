//
//  EndGameLayer.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/21/12.
//
//

#import <Foundation/Foundation.h>
#import "CCBReader.h"
#import "SceneManager.h"
#import "EndGameLayerProtocol.h"

@interface EndGameLayer : CCLayer<EndGameLayerProtocol> {
}

-(void)pressedNewGame:(id)sender;
-(void)pressedExit:(id)sender;

@end
