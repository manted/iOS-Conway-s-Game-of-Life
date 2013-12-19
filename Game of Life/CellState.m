//
//  CellState.m
//  Game of Life
//
//  Created by Manted on 17/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import "CellState.h"

@implementation CellState

-(id)initWithState:(int)state row:(int)row col:(int)col{
    self = [super init];
    if (self) {
        _currentState = state;
        _row = row;
        _col = col;
    }
    return self;
}

-(void)changeState{
    _currentState = !_currentState;
}
@end
