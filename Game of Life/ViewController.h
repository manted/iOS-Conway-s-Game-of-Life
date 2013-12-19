//
//  ViewController.h
//  Game of Life
//
//  Created by Manted on 17/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatesArray.h"
#import "CellView.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) StatesArray *statesArray;
@property (nonatomic, strong) NSTimer *timer;

-(void)setState:(int)state row:(int)row col:(int)col;
-(void)changeStateOfRow:(int)row col:(int)col;
-(void)updateCellViews;
- (IBAction)handleNextButton:(id)sender;
@end
