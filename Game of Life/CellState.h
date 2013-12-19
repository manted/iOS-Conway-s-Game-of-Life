//
//  CellState.h
//  Game of Life
//
//  Created by Manted on 17/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefinedConstants.h"


@interface CellState : NSObject

@property (nonatomic) int currentState;
@property (nonatomic) int nextState;

@property (nonatomic) int row;
@property (nonatomic) int col;

-(id)initWithState:(int)state row:(int)row col:(int)col;
-(void)changeState;

@end
