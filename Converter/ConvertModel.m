//
//  ConvertModel.m
//  Converter
//
//  Created by 1 on 5/12/15.
//  Copyright (c) 2015 1. All rights reserved.
//

#import "ConvertModel.h"

@implementation ConvertModel

- (instancetype)initWithArray:(NSArray *)array{
    self = [super init];
    if(self){
        self.EURUAHbuy = array[1][@"buy"];
        self.EURUAHsell = array[1][@"sale"];
        self.USDUAHbuy = array[2][@"buy"];
        self.USDUAHsell = array[2][@"sale"];
        
        NSLog(@"%@", self.EURUAHbuy);
        NSLog(@"%@", self.EURUAHsell);
        NSLog(@"%@", self.USDUAHbuy);
        NSLog(@"%@", self.USDUAHsell);
    }
    return self;
}

@end
