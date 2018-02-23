//
//  AIPatternSundry.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 1/8/13.
//
//

#import <Foundation/Foundation.h>
#import "AIPattern.h"

// Number of blocks used for the starting of the game.
#define kStartingFieldBlockCount 7

#define k9Pattern 9
#define k10Pattern 10
#define k12Pattern 12

@interface StartPattern : AIPattern
@end

@interface Easy1Pattern : AIPattern
@end

@interface Easy2Pattern : AIPattern
@end

@interface Easy3Pattern : AIPattern
@end

@interface SquarePattern : AIPattern
@end

@interface EasySequence1Pattern : AIPattern
@end

@interface XPattern : AIPattern
@end

@interface VPattern : AIPattern
@end

@interface CakePattern : AIPattern
@end

@interface TouchInsane1Pattern : AIPattern
@end

@interface TouchInsane2Pattern : AIPattern
@end

@interface Wall1Pattern : AIPattern
@end

@interface Touch1Pattern : AIPattern
@end

@interface TitleistPattern : AIPattern
@end

@interface TopFlightPattern : AIPattern
@end

@interface DunlopPattern : AIPattern
@end

@interface Dunlop2Pattern : AIPattern
@end

@interface Dunlop3Pattern : AIPattern
@end

@interface Dunlop4Pattern : AIPattern
@end

@interface PopupCrazyPattern : AIPattern
@end

