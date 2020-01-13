//
//  WCCYViewController.m
//  WccyTaskTool
//
//  Created by hanssea on 01/13/2020.
//  Copyright (c) 2020 hanssea. All rights reserved.
//

#import "WCCYViewController.h"
#import "WccyTaskTool.h"
@interface WCCYViewController ()

@end

@implementation WCCYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    
    [WccyTaskTool sendTask:@"1213123123" params:@{@"waybillUuid":@"1231231231213"} success:^(id  _Nonnull response) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
