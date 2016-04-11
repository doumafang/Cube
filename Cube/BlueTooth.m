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
}


- (void)test
{
    
}
- (instancetype)init
{
    self = [super init ];
    if (self) {
        
        [self viewDidLoad];
    }
    return self;
}

- (void)viewDidLoad {
    
    baby = [BabyBluetooth shareBabyBluetooth];
    [baby cancelAllPeripheralsConnection];
    baby.scanForPeripherals().begin();
    [self babyDelegate];
    
}


- (void)connect
{
    [SVProgressHUD showInfoWithStatus:@"开始连接设备"];
    baby.having(self.currPeripheral).and.channel(channelOnCharacteristicView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
    [baby cancelScan];

}

- (void)writeValue
{
    Byte b = 0X46;
    NSData *data = [NSData dataWithBytes:&b length:sizeof(b)];
    [self.currPeripheral writeValue:data forCharacteristic:self.characteristic type:CBCharacteristicWriteWithResponse];
}

-(void)babyDelegate{
    
    __weak typeof(self) weakSelf = self;
    [baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state == CBCentralManagerStatePoweredOn) {
            [SVProgressHUD showInfoWithStatus:@"设备打开成功，开始扫描设备"];
        }
    }];
    
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        NSLog(@"搜索到了设备:%@",peripheral.name);
        if ([peripheral.name isEqualToString:@"HC-08"]) {
            weakSelf.currPeripheral = peripheral;
            [weakSelf connect];
        }
    }];
    
    //设置发现设备的Services的委托
    [baby setBlockOnDiscoverServices:^(CBPeripheral *peripheral, NSError *error) {
        for (CBService *service in peripheral.services) {
            NSLog(@"搜索到服务:%@",service.UUID.UUIDString);
        }
    }];
    
    
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristics:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
        for (CBCharacteristic *c in service.characteristics) {
            NSLog(@"charateristic name is :%@",c.UUID);
        }
    }];
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristic:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptors:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    
    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        //最常用的场景是查找某一个前缀开头的设备
                if ([peripheralName hasPrefix:@"HC"] ) {
                    return YES;
                }
                return NO;
        
        //设置查找规则是名称大于0 ， the search rule is peripheral.name length > 0
        if (peripheralName.length >0) {
            return YES;
        }
        return NO;
    }];
    
    
    [baby setBlockOnCancelAllPeripheralsConnectionBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelAllPeripheralsConnectionBlock");
    }];
    
    [baby setBlockOnCancelScanBlock:^(CBCentralManager *centralManager) {
        NSLog(@"setBlockOnCancelScanBlock");
    }];
    
   
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    //连接设备->
    [baby setBabyOptionsWithScanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:nil scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
    
    BabyRhythm *rhythm = [[BabyRhythm alloc]init];
    
    
    //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [baby setBlockOnConnectedAtChannel:channelOnCharacteristicView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接成功",peripheral.name]];
    }];
    
    //设置设备连接失败的委托
    [baby setBlockOnFailToConnectAtChannel:channelOnCharacteristicView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--连接失败",peripheral.name);
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--连接失败",peripheral.name]];
    }];
    
    //设置设备断开连接的委托
    [baby setBlockOnDisconnectAtChannel:channelOnCharacteristicView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--断开连接",peripheral.name);
        [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"设备：%@--断开失败",peripheral.name]];
    }];
    
    //设置发现设备的Services的委托
    [baby setBlockOnDiscoverServicesAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, NSError *error) {
        [rhythm beats];
    }];
    //设置发现设service的Characteristics的委托
    [baby setBlockOnDiscoverCharacteristicsAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        NSLog(@"===service name:%@",service.UUID);
    }];
    //设置读取characteristics的委托
    [baby setBlockOnReadValueForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
        NSLog(@"characteristic name:%@ value is:%@",characteristics.UUID,characteristics.value);
    }];
    //设置发现characteristics的descriptors的委托
    [baby setBlockOnDiscoverDescriptorsForCharacteristicAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBCharacteristic *characteristic, NSError *error) {
        NSLog(@"===characteristic name:%@",characteristic.service.UUID);
        for (CBDescriptor *d in characteristic.descriptors) {
            NSLog(@"CBDescriptor name is :%@",d.UUID);
        }
    }];
    //设置读取Descriptor的委托
    [baby setBlockOnReadValueForDescriptorsAtChannel:channelOnCharacteristicView block:^(CBPeripheral *peripheral, CBDescriptor *descriptor, NSError *error) {
        NSLog(@"Descriptor name:%@ value is:%@",descriptor.characteristic.UUID, descriptor.value);
    }];
    
    //读取rssi的委托
    [baby setBlockOnDidReadRSSI:^(NSNumber *RSSI, NSError *error) {
        NSLog(@"setBlockOnDidReadRSSI:RSSI:%@",RSSI);
    }];
    
    
    //设置beats break委托
    [rhythm setBlockOnBeatsBreak:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsBreak call");
    }];
    
    //设置beats over委托
    [rhythm setBlockOnBeatsOver:^(BabyRhythm *bry) {
        NSLog(@"setBlockOnBeatsOver call");
    }];
    
    
}






@end
