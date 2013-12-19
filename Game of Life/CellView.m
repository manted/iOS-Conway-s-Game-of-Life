//
//  CellView.m
//  Game of Life
//
//  Created by Manted on 17/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import "CellView.h"

@implementation CellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame controller:(ViewController *)controller row:(int)row col:(int)col{
    self = [super initWithFrame:frame];
    if (self) {
        _row = row;
        _col = col;
        _tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap)];
        [self addGestureRecognizer:_tapRecognizer];
        _controller = controller;
        self.tag = 1;
        UIImage *bgImg = [UIImage imageNamed:@"Cell.png"];
        [self addSubview:[[UIImageView alloc]initWithImage:bgImg]];
    }
    return self;
}
-(void)handleTap{
//    NSLog(@"tap row:%i col:%i",_row,_col);
    [_controller changeStateOfRow:_row col:_col];
    [_controller updateCellViews];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
