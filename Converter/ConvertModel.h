//
//  ConvertModel.h
//  Converter
//
//  Created by 1 on 5/12/15.
//  Copyright (c) 2015 1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConvertModel : NSObject

@property (nonatomic, copy) NSNumber *EURUAHbuy;
@property (nonatomic, copy) NSNumber *EURUAHsell;
@property (nonatomic, copy) NSNumber *USDUAHbuy;
@property (nonatomic, copy) NSNumber *USDUAHsell;

-(instancetype)initWithArray:(NSArray *)dictionary;

@end
