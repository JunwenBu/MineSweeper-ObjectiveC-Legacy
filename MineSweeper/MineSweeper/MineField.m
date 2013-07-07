//  Author: Junwen Bu
//  Course: CIS 600
//  HW3
//
//  MineField.m
//  MineSweep
//
//  Created by Junwen Bu on 2/24/13.
//  Copyright (c) 2013 Junwen Bu. All rights reserved.
//

#import "MineField.h"
#import "Cell.h"

@implementation MineField

@synthesize mines, remainMines, flags;
@synthesize mineField;
@synthesize mineCells;
@synthesize xs, ys;
@synthesize blowUp;

- (id) init
{
    return [self initWithXs:10 Ys:10 Mines:15];
}

- (id) initWithXs:(int)nx Ys:(int)ny Mines:(int)m
{
    if(self = [super init])
    {
        
        blowUp = NO;
        xs = nx;
        ys = ny;
        mines = remainMines = flags = m;
        
        // initialize mine field matrix, here I use one-dimensional MSMutableArray: (xi,yi)=>yi*xs+xi
        mineField = [NSMutableArray arrayWithCapacity:xs*ys];
        mineCells = [NSMutableArray arrayWithCapacity:mines];
        for (int yi = 0; yi < ys; yi ++) {
            for (int xi = 0; xi < xs; xi ++) {
                Cell * cell = [[Cell alloc] initWithIsExplored:NO IsFlaged:NO X:xi Y:yi Value:0];
                [mineField addObject:cell];
            }
        }
        
        // set up mines randomly
        int mineSet = mines, randX = 0, randY = 0;
        while (mineSet > 0)
        {
            randX = arc4random()%xs;
            randY = arc4random()%ys;
            if([[mineField objectAtIndex:randY*xs+randX] cellValue] != -1)
            {
                [[mineField objectAtIndex:randY*xs+randX] setCellValue:-1];
                [mineCells addObject:[mineField objectAtIndex:randY*xs+randX]];
                mineSet--;
            }
        }
        
        // calculate 8 neighbour cell
        for (int yi=0; yi< ys; yi++)
        {
            for (int xi=0; xi<xs; xi++)
            {
                int tempValue = 0;
                if([[mineField objectAtIndex:yi*xs+xi] cellValue] != -1)
                {
                    if (xi-1>=0 && yi-1>=0 && [[mineField objectAtIndex:(yi-1)*xs+xi-1] cellValue]==-1) tempValue ++;
                    if (yi-1>=0 && [[mineField objectAtIndex:(yi-1)*xs+xi] cellValue]==-1) tempValue++;
                    if (xi+1<xs && yi-1>=0 && [[mineField objectAtIndex:(yi-1)*xs+xi+1] cellValue]==-1) tempValue++;
                    if (xi-1>=0 && [[mineField objectAtIndex:yi*xs+xi-1] cellValue]==-1) tempValue++;
                    if (xi+1<xs && [[mineField objectAtIndex:yi*xs+xi+1] cellValue]==-1) tempValue++;
                    if (xi-1>=0 && yi+1<ys && [[mineField objectAtIndex:(yi+1)*xs+xi-1] cellValue]==-1) tempValue++;
                    if (yi+1<ys && [[mineField objectAtIndex:(yi+1)*xs+xi] cellValue]==-1) tempValue++;
                    if (xi+1<xs && yi+1<ys && [[mineField objectAtIndex:(yi+1)*xs+xi+1] cellValue]==-1) tempValue++;
                    [[mineField objectAtIndex:yi*xs+xi] setCellValue:tempValue];
                }
            }
        }
    }
    return self;
}

// get around cells of cell at (xi, yi)
- (NSMutableArray *) cellAroundWithX:(int)xi Y:(int)yi
{
    NSMutableArray * retArray = [[NSMutableArray alloc]init];
    if (xi-1>=0 && yi-1>=0)
        [retArray addObject:[mineField objectAtIndex:(yi-1)*xs+xi-1]];
    if (yi-1>=0)
        [retArray addObject:[mineField objectAtIndex:(yi-1)*xs+xi]];
    if (xi+1<xs && yi-1>=0)
        [retArray addObject:[mineField objectAtIndex:(yi-1)*xs+xi+1]];
    if (xi-1>=0)
        [retArray addObject:[mineField objectAtIndex:yi*xs+xi-1]];
    if (xi+1<xs)
        [retArray addObject:[mineField objectAtIndex:yi*xs+xi+1]];
    if (xi-1>=0 && yi+1<ys)
        [retArray addObject:[mineField objectAtIndex:(yi+1)*xs+xi-1]];
    if (yi+1<ys)
        [retArray addObject:[mineField objectAtIndex:(yi+1)*xs+xi]];
    if (xi+1<xs && yi+1<ys)
        [retArray addObject:[mineField objectAtIndex:(yi+1)*xs+xi+1]];
    return retArray;
}

- (int) valueWithX:(int)xi Y:(int)yi
{
    return [[mineField objectAtIndex:(yi*xs)+xi] cellValue];
}

@end
