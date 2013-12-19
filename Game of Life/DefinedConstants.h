//
//  DefinedConstants.h
//  Game of Life
//
//  Created by Manted on 18/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ALIVE 0
#define DEAD 1

#define CELL_WIDTH 20
#define AREA_WIDTH 320
#define AREA_HEIGHT 400
#define NUM_OF_ROW AREA_HEIGHT / CELL_WIDTH
#define NUM_OF_COL AREA_WIDTH / CELL_WIDTH
#define CELL_TAG 1

@interface DefinedConstants : NSObject

@end
