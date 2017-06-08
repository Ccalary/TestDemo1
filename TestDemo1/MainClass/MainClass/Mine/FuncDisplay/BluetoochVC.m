//
//  BluetoochVC.m
//  TestDemo1
//
//  Created by caohouhong on 17/6/2.
//  Copyright © 2017年 caohouhong. All rights reserved.
//

#import "BluetoochVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
@interface BluetoochVC ()<CBCentralManagerDelegate, CBPeripheralManagerDelegate>

@end

@implementation BluetoochVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CBCentralManager *manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
