//
//  BlueTooth.h
//  Cube
//
//  Created by doumaaaaaaaa on 16/4/11.
//  Copyright © 2016年 doumafang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BabyBluetooth.h"
#import "SVProgressHUD.h"
@interface BlueTooth : NSObject
@property (nonatomic,strong)CBCharacteristic *characteristic;
@property (nonatomic,strong)CBPeripheral *currPeripheral;

- (void)test;

@end
