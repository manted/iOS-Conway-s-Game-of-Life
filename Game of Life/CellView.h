//
//  CellView.h
//  Game of Life
//
//  Created by Manted on 17/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@class ViewController;

@interface CellView : UIView

@property (nonatomic) int row;
@property (nonatomic) int col;

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@property (nonatomic, strong) ViewController *controller;

-(id)initWithFrame:(CGRect)frame controller:(ViewController*)controller row:(int)row col:(int)col;
@end
