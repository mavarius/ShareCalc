//
//  MSCBuyViewController.m
//  ShareCalc
//
//  Created by Daniel Campbell on 4/19/16.
//  Copyright © 2016 Daniel Campbell. All rights reserved.
//

#import "MSCBuyViewController.h"

@interface MSCBuyViewController ()

@end

@implementation MSCBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    isDecimal = FALSE;
    resultNumber = 0;
    _amountToInvest.adjustsFontSizeToFitWidth = TRUE;
    _buyPrice.adjustsFontSizeToFitWidth = TRUE;
    _commission.adjustsFontSizeToFitWidth = TRUE;
    _sharesToBuy.adjustsFontSizeToFitWidth = TRUE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



-(void)setResultWithNumber:(int)thenumber{
    if(!isDecimal){
        displayNumber *= 10;
        displayNumber += thenumber;
        
    }
}

- (IBAction)button1:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@1", _amountToInvest.text];
}

- (IBAction)button2:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@2", _amountToInvest.text];
}

- (IBAction)button3:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@3", _amountToInvest.text];
}

- (IBAction)button4:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@4", _amountToInvest.text];
}

- (IBAction)button5:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@5", _amountToInvest.text];
}

- (IBAction)button6:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@6", _amountToInvest.text];
}

- (IBAction)button7:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@7", _amountToInvest.text];
}

- (IBAction)button8:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@8", _amountToInvest.text];
}

- (IBAction)button9:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@9", _amountToInvest.text];
}

- (IBAction)button0:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@0", _amountToInvest.text];
}

- (IBAction)buttonDecimal:(id)sender {
    _amountToInvest.text = [NSString stringWithFormat:@"%@.", _amountToInvest.text];
}

- (IBAction)buttonSign:(id)sender {
    if (_amountToInvest.text) {
        _amountToInvest.text = [NSString stringWithFormat:@"-%@", _amountToInvest.text];
    } else {
        _amountToInvest.text = [NSString stringWithFormat:@"+%@", _amountToInvest.text];
    }
}
@end
