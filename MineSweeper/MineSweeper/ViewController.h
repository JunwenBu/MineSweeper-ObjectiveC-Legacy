//  Author: Junwen Bu
//  Course: CIS 600
//  HW3
//
//  ViewController.h
//  MineSweep
//
//  Created by Junwen Bu on 2/24/13.
//  Copyright (c) 2013 Junwen Bu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MineField.h"
#import "Cell.h"

// used to help implement button's double tap
BOOL isDoubleClick;
NSTimer *doubleClickTimer;

@interface ViewController : UIViewController

@property (strong,nonatomic) MineField * mField;
@property (nonatomic, assign) BOOL gameOver;

@property (weak, nonatomic) IBOutlet UILabel *gameInfo;
@property (weak, nonatomic) IBOutlet UILabel *gamePrompt;
@property (weak, nonatomic) IBOutlet UILabel *flagNumber;
@property (weak, nonatomic) IBOutlet UIButton *faceButton;
@property (weak, nonatomic) IBOutlet UIView *fieldView; // View which holds minefield

- (IBAction)newGame:(id)sender; // face button: click to start a new game
- (IBAction)getGameInfo:(id)sender;

@end
