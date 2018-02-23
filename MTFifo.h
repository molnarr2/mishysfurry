//
//  MTFifo.h
//  MishyFurry
//
//  Created by Robert Molnar 2 on 11/3/12.
//
//

#import <Foundation/Foundation.h>

@interface MTFifo : NSObject {
    // This is how large the FIFO container.
    int capacity;
    // Current position in the FIFO array.
    int fifoPos;
    // Current size of the valid objects in the FIFO array.
    int fifoSize;
    
    // contain of the objects in the FIFO container.
    NSMutableArray __strong *arrFifo;
    
    // The label at each array.
    int *arrFifoLabel;
}

// This will create the FIFO with capacity size.
-(id) initWithCapacity:(int)_capacity;

// This will add an object to the FIFO container.
// @param obj is the object to add.
// @param label is where at within the FIFO container to add.
-(int) addObject: (id) obj label:(int)label;


@end
