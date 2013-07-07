//  Author: Junwen Bu
//  Course: CIS 600
//  HW3
//
//  MineField.h
//  MineSweep
//
//  Created by Junwen Bu on 2/24/13.
//  Copyright (c) 2013 Junwen Bu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MineField : NSObject

@property (nonatomic, assign) int mines, remainMines, flags;
@property (strong, nonatomic, readonly) NSMutableArray* mineField;
@property (strong, nonatomic, readonly) NSMutableArray* mineCells;
@property (nonatomic, assign) int xs, ys;
@property (nonatomic, assign) BOOL blowUp;

- (id)initWithXs:(int)nx Ys:(int)ny Mines:(int) m;
- (NSMutableArray *) cellAroundWithX: (int)xi Y:(int) yi;
- (int) valueWithX: (int)xi Y:(int) yi;

@end
