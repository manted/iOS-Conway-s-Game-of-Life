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
            count += [self isAliveOfRow:0 col:1];
            count += [self isAliveOfRow:1 col:0];
            count += [self isAliveOfRow:1 col:1];
        }
        //right
        else if (col == NUM_OF_COL - 1){
            count += [self isAliveOfRow:0 col:col - 1];
            count += [self isAliveOfRow:1 col:col - 1];
            count += [self isAliveOfRow:1 col:col];
        }
        //centre
        else{
            count += [self isAliveOfRow:row col:col - 1];
            count += [self isAliveOfRow:row col:col + 1];
            count += [self isAliveOfRow:row + 1 col:col - 1];
            count += [self isAliveOfRow:row + 1 col:col];
            count += [self isAliveOfRow:row + 1 col:col + 1];
        }
    }
    //bottom
    else if (row == NUM_OF_ROW - 1){
        //left
        if (col == 0) {
            count += [self isAliveOfRow:row - 1 col:0];
            count += [self isAliveOfRow:row - 1 col:1];
            count += [self isAliveOfRow:row col:1];
        }
        //right
        else if (col == NUM_OF_COL - 1){
            count += [self isAliveOfRow:row - 1 col:col - 1];
            count += [self isAliveOfRow:row - 1 col:col];
            count += [self isAliveOfRow:row col:col - 1];
        }
        //centre
        else{
            count += [self isAliveOfRow:row col:col - 1];
            count += [self isAliveOfRow:row col:col + 1];
            count += [self isAliveOfRow:row - 1 col:col - 1];
            count += [self isAliveOfRow:row - 1 col:col];
            count += [self isAliveOfRow:row - 1 col:col + 1];
        }
    }
    //centre
    else{
        //left
        if (col == 0) {
            count += [self isAliveOfRow:row - 1 col:0];
            count += [self isAliveOfRow:row - 1 col:1];
            count += [self isAliveOfRow:row col:1];
            count += [self isAliveOfRow:row + 1 col:1];
            count += [self isAliveOfRow:row + 1 col:0];
        }
        //right
        else if (col == NUM_OF_COL - 1){
            count += [self isAliveOfRow:row - 1 col:col];
            count += [self isAliveOfRow:row - 1 col:col - 1];
            count += [self isAliveOfRow:row col:col - 1];
            count += [self isAliveOfRow:row + 1 col:col - 1];
            count += [self isAliveOfRow:row + 1 col:col];
        }
        //centre
        else{
            count += [self isAliveOfRow:row - 1 col:col - 1];
            count += [self isAliveOfRow:row - 1 col:col];
            count += [self isAliveOfRow:row - 1 col:col + 1];
            count += [self isAliveOfRow:row col:col - 1];
            count += [self isAliveOfRow:row col:col + 1];
            count += [self isAliveOfRow:row + 1 col:col - 1];
            count += [self isAliveOfRow:row + 1 col:col];
            count += [self isAliveOfRow:row + 1 col:col + 1];
        }
    }
    return count;
}

-(int)isAliveOfRow:(int)row col:(int)col{
    if ([self getCurrentStateOfRow:row col:col] ==  ALIVE) {
        return 1;
    }else{
        return 0;
    }
}

-(void)randomStates{
    for (NSMutableArray *rowArray in _rowArray) {
        for (CellState *aCellState in rowArray) {
            int r = arc4random() % 5;
            if (r < 2) {
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

-(int)countPopulation{
    int count = 0;
    for (NSMutableArray *rowArray in _rowArray) {
        for (CellState *aCellState in rowArray) {
            if (aCellState.currentState == ALIVE) {
                count++;
            }
        }
    }
    return count;
}

@end
