//
//  StatesArray.h
//  Game of Life
//
//  Created by Manted on 17/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellState.h"

@interface StatesArray : NSObject

@property (nonatomic, strong) NSMutableArray *rowArray;
//@property (nonatomic, strong) NSMutableArray *colArray;

-(id)initWithRow:(int)row col:(int)col;
-(int)getCurrentStateOfRow:(int)row col:(int)col;
-(int)getNextStateOfRow:(int)row col:(int)col;
-(void)setState:(int)state row:(int)row col:(int)col;
-(void)changeStateOfRow:(int)row col:(int)col;
-(void)goToNextGeneration;
-(void)randomStates;
-(void)clear;
@end
