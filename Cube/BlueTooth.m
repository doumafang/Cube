//
//  BlueTooth.m
//  Cube
//
//  Created by doumaaaaaaaa on 16/4/11.
//  Copyright © 2016年 doumafang. All rights reserved.
//
#define width [UIScreen mainScreen].bounds.size.width
#define height [UIScreen mainScreen].bounds.size.height
#define channelOnCharacteristicView @"CharacteristicView"

#import "BlueTooth.h"

@implementation BlueTooth
{
    BabyBluetooth *baby;
    NSString *nofi;
}

- (void)openBB
{
    
}

- (instancetype)init
{
    self = [super init ];
    if (self) {
        baby = [BabyBluetooth shareBabyBluetooth];
        [baby cancelAllPeripheralsConnection];
        baby.scanForPeripherals().begin();
        [self babyDelegate];
    }
    return self;
}


- (void)connect
{
    [RKDropdownAlert title:@"BEGIN TO CONNECT"];
    [baby cancelScan];
    baby.having(self.currPeripheral).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
}

-(void)sendDataToBB:(NSString *)sendData
{
    if (self.currPeripheral) {
        if (self.characteristic) {
            
            NSData *data = [sendData dataUsingEncoding:NSASCIIStringEncoding];
            [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithoutResponse];
        }
    }
}

- (void)babyDelegate{
    
    
    __weak typeof(self) weakSelf = self;
    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            [RKDropdownAlert title:@"BLUETOOTH IS OPEN"];
        }
    }];
    
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        if ([peripheral.name isEqualToString:@"HC-08"]) {
            [RKDropdownAlert title:@"GOT THE CAR"];
            self.currPeripheral = peripheral;
            [self connect];
        }
    }];
    
    [baby setBlockOnConnected:^(CBCentralManager *central, CBPeripheral *peripheral) {
        NSLog(@"设备：%@--连接成功",peripheral.name);
        [RKDropdownAlert title:@"SUCCESS CONNECT THE CAR"];
    }];
    
    [baby setBlockOnDisconnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--断开连接",peripheral.name);
        [RKDropdownAlert title:@"DISCONNECT THE CAR"];
    }];
    
    [baby setBlockOnFailToConnect:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--连接失败",peripheral.name);
        [RKDropdownAlert title:@"FAIL CONNECT THE CAR"];

    }];
        
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        
        NSLog(@"%@",characteristic);
        if ([characteristic.UUID.UUIDString isEqualToString:@"FFE1"]) {
            self.characteristic = characteristic;
        }
    }];
    
    [baby setBlockOnDidWriteValueForCharacteristic:^(CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"成功写入 characteristic:%@ and new value:%@",characteristic.UUID, characteristic.value);
 
    }];
    
    
    

    
    
    
    
    
    
}






@end
