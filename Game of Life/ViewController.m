//
//  ViewController.m
//  Game of Life
//
//  Created by Manted on 17/12/2013.
//  Copyright (c) 2013 Ye Hua. All rights reserved.
//

#import "ViewController.h"
#import "DefinedConstants.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    _statesArray = [[StatesArray alloc]initWithRow:NUM_OF_ROW col:NUM_OF_COL];
    [self addCells];
    [self updateCellViews];
    [self addNextButton];
    [self addRandomButton];
    [self addClearButton];
//    [self addSwitchButton];
    [self addSegmentedControl];
    _speed = 0.5f;
}

-(void)addNextButton{
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.frame = CGRectMake(10, 404, 60, 30);
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(handleNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

-(void)addRandomButton{
    UIButton *randomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    randomButton.frame = CGRectMake(10, 444, 80, 30);
    [randomButton setTitle:@"Random" forState:UIControlStateNormal];
    [randomButton addTarget:self action:@selector(handleRandomButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:randomButton];
}

-(void)addClearButton{
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clearButton.frame = CGRectMake(100, 444, 100, 30);
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(handleClearButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
}

//-(void)addSwitchButton{
//    UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(120, 444, 80, 30)];
//    [switchButton setOn:NO];
//    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:switchButton];
//}

-(void)addSegmentedControl{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"Stop",@"Slow",@"Med",@"Fast",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(80, 404, 230, 30);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(handleSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}

-(void)addCells{
    for (int row = 0; row < NUM_OF_ROW; row++) {
        for (int col = 0; col < NUM_OF_COL; col++) {
            CellView *aCellView = [[CellView alloc]initWithFrame:CGRectMake(CELL_WIDTH*col, CELL_WIDTH*row, CELL_WIDTH, CELL_WIDTH) controller:self row:row col:col];
            [self.view addSubview:aCellView];
        }
    }
}

-(void)updateCellViews{
    NSArray *allViews = [self.view subviews];
    for (UIView *v in allViews) {
        if (v.tag == CELL_TAG) {
            CellView *aCellV = (CellView*)v;
            int state = [_statesArray getCurrentStateOfRow:aCellV.row col:aCellV.col];
            if (state == ALIVE) {
                [aCellV setBackgroundColor:[UIColor blackColor]];
            }else if(state == DEAD){
                [aCellV setBackgroundColor:[UIColor whiteColor]];
            }
        }
    }
}

- (IBAction)handleNextButton:(id)sender {
    [self next];
}

-(IBAction)handleRandomButton:(id)sender{
    [_statesArray randomStates];
    [self updateCellViews];
}

-(IBAction)handleClearButton:(id)sender{
    [_statesArray clear];
    [self updateCellViews];
}

-(IBAction)switchAction:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_speed
                                                          target:self
                                                        selector:@selector(next)
                                                        userInfo:nil
                                                         repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }else {
        [_timer invalidate];
    }
}

-(IBAction)handleSegmentedControl:(id)sender{
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    NSInteger Index = seg.selectedSegmentIndex;
    
    switch (Index) {
        case 0:
            [_timer invalidate];
            break;
        case 1:
            [_timer invalidate];
            _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                      target:self
                                                    selector:@selector(next)
                                                    userInfo:nil
                                                     repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            break;
        case 2:
            [_timer invalidate];
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                      target:self
                                                    selector:@selector(next)
                                                    userInfo:nil
                                                     repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            break;
        case 3:
            [_timer invalidate];
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self
                                                    selector:@selector(next)
                                                    userInfo:nil
                                                     repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
            break;
        default:
            break;
    }
}

-(void)next{
    [_statesArray goToNextGeneration];
    [self updateCellViews];
}


-(void)setState:(int)state row:(int)row col:(int)col{
    [_statesArray setState:state row:row col:col];
}

-(void)changeStateOfRow:(int)row col:(int)col{
    [_statesArray changeStateOfRow:row col:col];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
