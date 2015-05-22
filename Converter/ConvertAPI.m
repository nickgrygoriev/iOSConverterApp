//
//  ConvertAPI.m
//  Converter
//
//  Created by 1 on 5/22/15.
//  Copyright (c) 2015 1. All rights reserved.
//

#import "ConvertAPI.h"

NSString *const kAPIURL = @"https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5";

@interface ConvertAPI()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation ConvertAPI

-(void)requestRates{
    NSString *fullURL = kAPIURL;
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:self.queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(!connectionError) {
            NSError *error;
            NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if(!error){
                ConvertModel *convertModel = [[ConvertModel alloc]initWithArray:json];
                [self.delegate api:self didReceiveRates:convertModel];
                NSLog(@"%@", json);
            }
        } else{
            NSLog(@"%@", connectionError);
        }
    }];
}

-(NSOperationQueue *)queue{
    if(!_queue){
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

@end
