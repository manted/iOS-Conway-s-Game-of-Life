//
//  DefinedConstants.h
//  Game of Life
//
//  Created by Manted on 18/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_WIDESCREEN ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPhone" ] )
#define IS_IPOD   ( [ [ [ UIDevice currentDevice ] model ] isEqualToString: @"iPod touch" ] )
#define IS_IPHONE_5 ( IS_IPHONE && IS_WIDESCREEN )

#define ALIVE 0
#define DEAD 1

#define CELL_WIDTH 10
#define AREA_WIDTH 320
#define AREA_HEIGHT (IS_WIDESCREEN?488:400)
#define NUM_OF_ROW AREA_HEIGHT / CELL_WIDTH
#define NUM_OF_COL AREA_WIDTH / CELL_WIDTH
#define CELL_TAG 1

@interface DefinedConstants : NSObject

@end
