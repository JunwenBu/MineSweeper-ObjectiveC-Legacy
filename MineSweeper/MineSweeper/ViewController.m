//  Author: Junwen Bu
//  Course: CIS 600
//  HW3
//
//  ViewController.m
//  MineSweep
//
//  Created by Junwen Bu on 2/24/13.
//  Copyright (c) 2013 Junwen Bu. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize mField; // MineField
@synthesize gameOver;
@synthesize flagNumber;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"happy.png"] forState:UIControlStateNormal];
    [_gameInfo setText:@"Mine Sweeper"];
    [_gamePrompt setText:@"Click me to start a new game."];
    gameOver = NO;
    CGRect bounds = [_fieldView bounds];
    CGFloat width = CGRectGetWidth(bounds);
    CGFloat height = CGRectGetHeight(bounds);
    
    // initilize minefield with 16 x 16 game grid with 35 mines
    mField = [[MineField alloc] initWithXs:16 Ys:16 Mines:35];
    int xnumber = mField.xs;
    int ynumber = mField.ys;
    [flagNumber setText:[NSString stringWithFormat: @"%i", mField.flags]];
    CGFloat cellWidth = width/xnumber < height/ynumber? width/xnumber : height/ynumber;
    
    // add buttons to the subview
    for (int yi = 0; yi<ynumber; yi++) {
        for (int xi =0; xi<xnumber; xi++) {
            Cell * cellbutton = [mField.mineField objectAtIndex:yi*xnumber+xi];
			[cellbutton setFrame:CGRectMake(xi * cellWidth, yi * cellWidth, cellWidth, cellWidth)];
			[cellbutton addTarget:self action:@selector(clickCell:) forControlEvents:UIControlEventTouchUpInside];
            [cellbutton setBackgroundImage:[UIImage imageNamed:@"00.png"] forState:UIControlStateNormal];
			[_fieldView addSubview: cellbutton];
        }
    }
	
}

- (void)clickCell:(Cell *)sender{
    if(gameOver==NO)
    {
        if (isDoubleClick==YES)
        {
            // DOUBLE CLICK
            isDoubleClick=NO;
            // open cells: if the value of a cell is zero than open cells around it
            [sender expandAroundCells:self.mField];
            [flagNumber setText:[NSString stringWithFormat: @"%i", mField.flags]];
            if (mField.blowUp)
            {   // game is lost
                [_faceButton setBackgroundImage:[UIImage imageNamed:@"cry.png"] forState:UIControlStateNormal];
                [_gamePrompt setText:@"Bang! Bang! Click me to try again."];
                [_gameInfo setText:@"I'm dead！(⊙ˍ⊙) Lost"];
                gameOver = YES;
            }
        }
        
        else if(isDoubleClick==NO)
        {
            //SINGLE CLICK 
            isDoubleClick=YES;
            doubleClickTimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(TimerReload:) userInfo:nil repeats:NO];
            if (sender.isExplored == NO)
            {   // set Flag in cell
                if (sender.isFlaged == NO)
                {
                    sender.isFlaged = YES;
                    [sender setBackgroundImage:[UIImage imageNamed:@"flag.png"] forState:UIControlStateNormal];
                    mField.flags--;
                    [flagNumber setText:[NSString stringWithFormat: @"%i", mField.flags]];
                    if (sender.cellValue == -1)
                    {   // cell is a mine
                        if(--mField.remainMines==0 && mField.flags == 0)
                        {   // win the game
                            [_faceButton setBackgroundImage:[UIImage imageNamed:@"win.png"] forState:UIControlStateNormal];
                            [_gamePrompt setText:@"Congratulations!"];
                            [_gameInfo setText:@"[]~(￣▽￣)~* You win!"];
                            gameOver = YES;
                        }
                    }
                    
                }else // isFlaged is YES, already flaged
                {
                    sender.isFlaged = NO;
                    [sender setBackgroundImage:[UIImage imageNamed:@"00.png"] forState:UIControlStateNormal];
                    mField.flags++;
                    [flagNumber setText:[NSString stringWithFormat: @"%i", mField.flags]];
                    if (sender.cellValue == -1) {
                        mField.remainMines++;
                    }else // is not mine
                    {   // after remove unnecessary flags the game may win
                        if(mField.remainMines==0 && mField.flags == 0)
                        {
                            [_faceButton setBackgroundImage:[UIImage imageNamed:@"win.png"] forState:UIControlStateNormal];
                            [_gamePrompt setText:@"Congratulations!"];
                            [_gameInfo setText:@"[]~(￣▽￣)~* You win!"];
                            gameOver = YES;
                        }
                    }
                }
            }
        }
    }
}

// help to implement double tap on button object
-(void)TimerReload:(NSTimer *)timer
{
    doubleClickTimer = nil;
    isDoubleClick = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newGame:(id)sender {
    [self viewDidLoad];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [_faceButton setBackgroundImage:[UIImage imageNamed:@"happy.png"] forState:UIControlStateNormal];
    [self viewDidLoad];
}

- (IBAction)getGameInfo:(id)sender {
    UIAlertView *infoPrompt = [[UIAlertView alloc]initWithTitle:@"Mine Sweeper" message:@"A famouse game. The object of the game is to clear an abstract minefield without detonating a mine.\nAuthor: Junwen Bu\nVersion: 1.0" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [infoPrompt show];
}
@end
