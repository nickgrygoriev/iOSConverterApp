//
//  ConvertAPI.h
//  Converter
//
//  Created by 1 on 5/22/15.
//  Copyright (c) 2015 1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConvertModel.h"

@protocol ConvertAPIDelegate <NSObject>

- (void)api:(id)sender didReceiveRates:(ConvertModel *)convertModel;

@end

@interface ConvertAPI : NSObject

- (void)requestRates;

@property (nonatomic, weak) id<ConvertAPIDelegate> delegate;

@end
