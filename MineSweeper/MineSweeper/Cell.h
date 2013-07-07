//  Author: Junwen Bu
//  Course: CIS 600
//  HW3
//
//  Cell.h
//  MineSweep
//
//  Created by Junwen Bu on 2/24/13.
//  Copyright (c) 2013 Junwen Bu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MineField.h"

@interface Cell : UIButton
{
    BOOL isExplored, isFlaged;
    int x, y;
    int cellValue;
}

@property (nonatomic, assign) BOOL isExplored, isFlaged;
@property (nonatomic, assign) int x, y;
@property (nonatomic, assign) int cellValue;

- (id)initWithIsExplored:(BOOL) iE IsFlaged:(BOOL) iF X:(int)xi Y:(int)yi Value:(int) v;
- (void) expandAroundCells:(MineField *)field;

@end
