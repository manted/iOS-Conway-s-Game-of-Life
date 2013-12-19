//
//  StatesArray.m
//  Game of Life
//
//  Created by Manted on 17/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import "StatesArray.h"
#import "DefinedConstants.h"
#include <stdlib.h>

@implementation StatesArray

-(id)initWithRow:(int)row col:(int)col{
    self = [super init];
    if (self) {
        _rowArray = [[NSMutableArray alloc]initWithCapacity:row];
        for (int i = 0; i < row; i++) {
            NSMutableArray *colArray = [[NSMutableArray alloc]initWithCapacity:col];
            for (int j = 0; j < col; j++) {
                CellState *aCell = [[CellState alloc]initWithState:DEAD row:i col:j];
                [colArray addObject:aCell];
            }
            [_rowArray addObject:colArray];
        }
    }
    return self;
}

-(int)getCurrentStateOfRow:(int)row col:(int)col{
    return [[[_rowArray objectAtIndex:row]objectAtIndex:col]currentState];
}

-(int)getNextStateOfRow:(int)row col:(int)col{
    return [[[_rowArray objectAtIndex:row]objectAtIndex:col]nextState];
}

-(void)setState:(int)state row:(int)row col:(int)col{
    [[[_rowArray objectAtIndex:row]objectAtIndex:col]setCurrentState:state];
}

-(void)changeStateOfRow:(int)row col:(int)col{
    [[[_rowArray objectAtIndex:row]objectAtIndex:col]changeState];
}

-(void)goToNextGeneration{
    for (NSMutableArray *rowArray in _rowArray) {
        for (CellState *cellState in rowArray) {
            int count = [self countCellOfRow:cellState.row col:cellState.col];
            if (cellState.currentState == ALIVE) {
                if (count == 2 || count == 3) {
                    [cellState setNextState:ALIVE];
                }else{
                    [cellState setNextState:DEAD];
                }
            }else{
                if (count == 3) {
                    [cellState setNextState:ALIVE];
                }else{
                    [cellState setNextState:DEAD];
                }
            }
        }
    }
    //update current state
    for (NSMutableArray *rowArray in _rowArray) {
        for (CellState *cellState in rowArray) {
            [cellState setCurrentState:cellState.nextState];
        }
    }
}

-(int)countCellOfRow:(int)row col:(int)col{
    int count = 0;
    //top
    if (row == 0) {
        //left
        if (col == 0) {
            if ([self getCurrentStateOfRow:0 col:1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:1 col:0] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:1 col:1] == ALIVE) {
                count++;
            }
        }
        //right
        else if (col == NUM_OF_COL - 1){
            if ([self getCurrentStateOfRow:0 col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:1 col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:1 col:col] == ALIVE) {
                count++;
            }
        }
        //centre
        else{
            if ([self getCurrentStateOfRow:row col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row col:col + 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:col] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:col + 1] == ALIVE) {
                count++;
            }
        }
    }
    //bottom
    else if (row == NUM_OF_ROW - 1){
        //left
        if (col == 0) {
            if ([self getCurrentStateOfRow:row - 1 col:0] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row - 1 col:1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row col:1] == ALIVE) {
                count++;
            }
        }
        //right
        else if (col == NUM_OF_COL - 1){
            if ([self getCurrentStateOfRow:row - 1 col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row - 1 col:col] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row col:col - 1] == ALIVE) {
                count++;
            }
        }
        //centre
        else{
            if ([self getCurrentStateOfRow:row col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row col:col + 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row - 1 col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row - 1 col:col] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row - 1 col:col + 1] == ALIVE) {
                count++;
            }
        }
    }
    //centre
    else{
        //left
        if (col == 0) {
            if ([self getCurrentStateOfRow:row - 1 col:0] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row - 1 col:1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row col:1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:0] == ALIVE) {
                count++;
            }
        }
        //right
        else if (col == NUM_OF_COL - 1){
            if ([self getCurrentStateOfRow:row - 1 col:col] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row - 1 col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:col] == ALIVE) {
                count++;
            }
        }
        //centre
        else{
            if ([self getCurrentStateOfRow:row - 1 col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row - 1 col:col] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row - 1 col:col + 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row col:col + 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:col - 1] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:col] == ALIVE) {
                count++;
            }
            if ([self getCurrentStateOfRow:row + 1 col:col + 1] == ALIVE) {
                count++;
            }
        }
    }
    return count;
}

-(void)randomStates{
    for (NSMutableArray *rowArray in _rowArray) {
        for (CellState *aCellState in rowArray) {
            int r = arc4random() % 3;
            if (r == 0) {
                [aCellState setCurrentState:ALIVE];
            }else{
                [aCellState setCurrentState:DEAD];
            }
            
        }
    }
}

-(void)clear{
    for (NSMutableArray *rowArray in _rowArray) {
        for (CellState *aCellState in rowArray) {
            [aCellState setCurrentState:DEAD];
        }
    }
}

@end
