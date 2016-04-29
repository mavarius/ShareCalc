//
//  MSCBuyViewController.h
//  ShareCalc
//
//  Created by Daniel Campbell on 4/19/16.
//  Copyright © 2016 Daniel Campbell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

int operation;
double displayNumber;
double resultNumber;
BOOL isDecimal;

@interface MSCBuyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *amountToInvest;
@property (weak, nonatomic) IBOutlet UITextField *buyPrice;
@property (weak, nonatomic) IBOutlet UITextField *commission;
@property (weak, nonatomic) IBOutlet UITextField *sharesToBuy;

-(void)setResultWithNumber:(int)thenumber;

- (IBAction)button1:(id)sender;
- (IBAction)button2:(id)sender;
- (IBAction)button3:(id)sender;
- (IBAction)button4:(id)sender;
- (IBAction)button5:(id)sender;
- (IBAction)button6:(id)sender;
- (IBAction)button7:(id)sender;
- (IBAction)button8:(id)sender;
- (IBAction)button9:(id)sender;
- (IBAction)button0:(id)sender;
- (IBAction)buttonDecimal:(id)sender;
- (IBAction)buttonSign:(id)sender;

@end
