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
    [self addSegmentedControl];
    
    _time = 0;
    _population = 0;
    
    [self addLabels];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
}

-(void)addNextButton{
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    nextButton.frame = CGRectMake(10, AREA_HEIGHT + 4, 60, 30);
    [nextButton setTitle:@"Next" forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(handleNextButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
}

-(void)addRandomButton{
    UIButton *randomButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    randomButton.frame = CGRectMake(10, AREA_HEIGHT + 44, 68, 30);
    [randomButton setTitle:@"Random" forState:UIControlStateNormal];
    [randomButton addTarget:self action:@selector(handleRandomButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:randomButton];
}

-(void)addClearButton{
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    clearButton.frame = CGRectMake(84, AREA_HEIGHT + 44, 56, 30);
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(handleClearButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
}

-(void)addSegmentedControl{
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"Stop",@"Slow",@"Med",@"Fast",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(80, AREA_HEIGHT + 4, 230, 30);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(handleSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
}

-(void)addLabels{
    _timeLb = [[UILabel alloc]initWithFrame:CGRectMake(150, AREA_HEIGHT + 44, 60, 30)];
    _popLb = [[UILabel alloc]initWithFrame:CGRectMake(214, AREA_HEIGHT + 44, 100, 30)];
    [_timeLb setFont:[UIFont systemFontOfSize:14]];
    [_popLb setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:_timeLb];
    [self.view addSubview:_popLb];
    [self setLabelText];
}

-(void)setLabelText{
    [_timeLb setText:[NSString stringWithFormat:@"Time:%i",_time]];
    [_popLb setText:[NSString stringWithFormat:@"Population:%i",_population]];
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
    _time = 0;
    [self countPopulation];
    [self setLabelText];
}

-(IBAction)handleClearButton:(id)sender{
    _time = 0;
    _population = 0;
    [_statesArray clear];
    [self updateCellViews];
    [self setLabelText];
}

-(IBAction)handleSegmentedControl:(id)sender{
    UISegmentedControl *seg = (UISegmentedControl*)sender;
    NSInteger Index = seg.selectedSegmentIndex;
    
    float speed = 1.0f;
    BOOL isStopped = YES;
    switch (Index) {
        case 0:
            isStopped = YES;
            break;
        case 1:
            speed = 1;
            isStopped = NO;
            break;
        case 2:
            speed = 0.5f;
            isStopped = NO;
            break;
        case 3:
            speed = 0.1f;
            isStopped = NO;
            break;
        default:
            break;
    }
    [_timer invalidate];
    if (isStopped == NO) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:speed
                                                  target:self
                                                selector:@selector(next)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

-(void)next{
    [_statesArray goToNextGeneration];
    [self updateCellViews];
    _time++;
    [self countPopulation];
    [self setLabelText];
}

-(void)countPopulation{
    _population = [_statesArray countPopulation];
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
