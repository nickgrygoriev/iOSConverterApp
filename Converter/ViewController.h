//
//  ViewController.h
//  Converter
//
//  Created by 1 on 4/29/15.
//  Copyright (c) 2015 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *ConvertFromField;
@property (weak, nonatomic) IBOutlet UITextField *ConvertToField;
@property (weak, nonatomic) IBOutlet UIButton *ConvertButton;
@property (weak, nonatomic) IBOutlet UIPickerView *FromPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *ToPicker;

@end

