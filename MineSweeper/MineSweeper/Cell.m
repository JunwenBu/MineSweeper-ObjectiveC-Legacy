//  Author: Junwen Bu
//  Course: CIS 600
//  HW3
//
//  Cell.m
//  MineSweep
//
//  Created by Junwen Bu on 2/24/13.
//  Copyright (c) 2013 Junwen Bu. All rights reserved.
//

#import "Cell.h"

@implementation Cell

@synthesize isExplored, isFlaged;
@synthesize x, y;
@synthesize cellValue;

- (id) init
{
    if(self = [super init])
    {
        isExplored = NO;
        isFlaged = NO;
        x = 0;
        y = 0;
        cellValue = 0;
    }
    return self;
}

-(id) initWithIsExplored:(BOOL)iE IsFlaged:(BOOL)iF X:(int)xi Y:(int)yi Value:(int)v
{
    if(self = [super init])
    {
        isExplored = iE;
        isFlaged = iF;
        x = xi;
        y = yi;
        cellValue = v;
    }
    return self;
}

- (void) expandAroundCells:(MineField *)field
{
    // get Value of cell
    if(isExplored == NO)
    {
        isExplored = YES;
        if (isFlaged) {
            isFlaged = NO;
            field.flags++;
        }
        int a = cellValue;
        if (a < 0)
        {
            // you lost the game
            field.blowUp = YES;
            for (Cell * mineCell in [field mineCells])
            {
                if (mineCell.x==self.x && mineCell.y==self.y)
                    [self setBackgroundImage:[UIImage imageNamed:@"13.png"] forState:UIControlStateNormal];
                else if(mineCell.isFlaged)
                    [mineCell setBackgroundImage:[UIImage imageNamed:@"flag_down.png"] forState:UIControlStateNormal];
                else
                    [mineCell setBackgroundImage:[UIImage imageNamed:@"12.png"] forState:UIControlStateNormal];
            }
        }else if(a == 0)
        {
            [self setBackgroundImage:[UIImage imageNamed:@"09.png"] forState:UIControlStateNormal];
            for(Cell * roundCell in [field cellAroundWithX:x Y:y])
                [roundCell expandAroundCells:field];
        }else{
            switch (a) {
                case 1:
                    [self setBackgroundImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];break;
                case 2:
                    [self setBackgroundImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];break;
                case 3:
                    [self setBackgroundImage:[UIImage imageNamed:@"03.png"] forState:UIControlStateNormal];break;
                case 4:
                    [self setBackgroundImage:[UIImage imageNamed:@"04.png"] forState:UIControlStateNormal];break;
                case 5:
                    [self setBackgroundImage:[UIImage imageNamed:@"05.png"] forState:UIControlStateNormal];break;
                case 6:
                    [self setBackgroundImage:[UIImage imageNamed:@"06.png"] forState:UIControlStateNormal];break;
                case 7:
                    [self setBackgroundImage:[UIImage imageNamed:@"07.png"] forState:UIControlStateNormal];break;
                case 8:
                    [self setBackgroundImage:[UIImage imageNamed:@"08.png"] forState:UIControlStateNormal];break;
                default:break;
            }
        }
    }
}

@end

