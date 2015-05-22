//
//  ViewController.m
//  Converter
//
//  Created by 1 on 4/29/15.
//  Copyright (c) 2015 1. All rights reserved.
//

#import "ViewController.h"
#import "ConvertModel.h"
#import "ConvertAPI.h"

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate, ConvertAPIDelegate>

    @property(nonatomic, strong) NSString *FromPickerCurrency;
    @property(nonatomic, strong) NSString *ToPickerCurrency;
    @property(nonatomic, strong) NSArray *FromPickerData;
    @property(nonatomic, strong) NSArray *ToPickerData;
    @property(nonatomic, strong) ConvertModel *convertModel;
    @property (nonatomic, strong) ConvertAPI *api;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateRates];
    
    //Init data
    self.FromPickerData = @[@"USD", @"EUR", @"UAH"];
    self.ToPickerData = @[@"USD", @"EUR", @"UAH"];
    
    [_FromPicker selectRow:1 inComponent:0 animated: YES];
    [_ToPicker selectRow:1 inComponent:0 animated: YES];
    self.FromPickerCurrency = self.FromPickerData[1];
    self.ToPickerCurrency = self.ToPickerData[1];
}

- (void)updateRates{
    [self.api requestRates];
}

#pragma mark -

-(void)api:(id)sender didReceiveRates:(ConvertModel *)convertModel{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.convertModel = convertModel;
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView: (UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.FromPickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return self.FromPickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView==self.FromPicker){
        self.FromPickerCurrency=self.FromPickerData[row];
        //[self.ConvertFromField setText:(_FromPickerData[row])];
    }
    if(pickerView==self.ToPicker){
        self.ToPickerCurrency=self.ToPickerData[row];
        //[self.ConvertToField setText:(_ToPickerData[row])];
    }
}

- (IBAction)Convert:(id)sender {
    [self updateRates];
    double currency = [self.ConvertFromField.text doubleValue];
    double convertedCurrency = [self Convert:currency From:self.FromPickerCurrency Into:self.ToPickerCurrency];
    
    
    NSString* convertedString = [NSString stringWithFormat:@"%.2f", convertedCurrency];
    [self.ConvertToField setText:(convertedString)];
}

- (IBAction)ClearAllButton:(id)sender {
    [self.ConvertToField setText:(@"")];
    [self.ConvertFromField setText:(@"")];
}

-(double)Convert:(double)currency From:(NSString*)currencyFrom Into:(NSString*)currencyTo{
    if([currencyFrom isEqualToString:@"USD"]){
        if([currencyTo isEqualToString:@"EUR"]){
            return currency*[self.convertModel.USDUAHbuy doubleValue]/[self.convertModel.EURUAHsell doubleValue];
        }
        if([currencyTo isEqualToString:@"UAH"]){
            return currency*[self.convertModel.USDUAHbuy doubleValue];
        }
    }
    if([currencyFrom isEqualToString:@"EUR"]){
        if([currencyTo isEqualToString:@"USD"]){
            return currency*[self.convertModel.EURUAHbuy doubleValue]/[self.convertModel.USDUAHsell doubleValue];
        }
        if([currencyTo isEqualToString:@"UAH"]){
            return currency*[self.convertModel.EURUAHbuy doubleValue];
        }
    }
    if([currencyFrom isEqualToString:@"UAH"]){
        if([currencyTo isEqualToString:@"USD"]){
            return currency/[self.convertModel.USDUAHsell doubleValue];
        }
        if([currencyTo isEqualToString:@"EUR"]){
            return currency/[self.convertModel.EURUAHsell doubleValue];
        }
    }
    return currency;
}

#pragma mark -

- (ConvertAPI *)api {
    if(!_api) {
        _api = [ConvertAPI new];
        _api.delegate = self;
    }
    return _api;
}

@end
