//
//  keyBTLEPeripheral.m
//  plintaKeySimulator
//
//  Created by Michael Rahr on 04/04/14.
//  Copyright (c) 2014 Plinta Vinnova. All rights reserved.
//

#import "keyBTLEPeripheral.h"
#import <AudioToolbox/AudioToolbox.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "plinta_car_service.h"


@protocol keyDelegate <NSObject>

//Must implement, this could and should be move to MqttCleint
@required
- (void) didReceivedReadRequest: (NSUInteger)code;




@end


@interface keyBTLEPeripheral() <CBPeripheralManagerDelegate>


@property (strong, nonatomic) CBPeripheralManager       *plinta_car_peripheralManager;
@property (strong, nonatomic) CBMutableCharacteristic   *plinta_car_ID_Characteristic;
@property (strong, nonatomic) CBMutableCharacteristic   *plinta_car_PASSWORD_Characteristic;
@property (strong, nonatomic) CBMutableCharacteristic   *plinta_car_Command_Characteristic;
@property (strong,nonatomic) NSData *myID;

@end
@implementation keyBTLEPeripheral
@synthesize password;
@synthesize uiid;


-(keyBTLEPeripheral*) initWithClientId:(uint )clientId  {

    uiid=clientId;
    password=123456789;
    return self;
}




#pragma delegate_for_peripheral_manager

/** Required protocol method.  A full app should take care of all the possible states,
 *  but we're just waiting for  to know when the CBPeripheralManager is ready
 */
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral
{
    // Opt out from any other state
    if (peripheral.state != CBPeripheralManagerStatePoweredOn) {
        
        NSLog(@"UPS Something went wrong, fix it please");
        return;
    }
    
    // We're in CBPeripheralManagerStatePoweredOn state...
    NSLog(@"self.peripheralManager powered on.");
    
    // ... so build our service.
    
    // Start with the CBMutableCharacteristic
    self.plinta_car_ID_Characteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:PLINTA_CAR_ID_CHA_UUID]
                                                                                        properties:CBCharacteristicPropertyRead
                                                                                        value:nil
                                                                                        permissions:CBAttributePermissionsReadable];
    self.plinta_car_PASSWORD_Characteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:PLINTA_CAR_PASSWORD_CHA_UUID]
                                                                                        properties:CBCharacteristicPropertyRead
                                                                                        value:nil
                                                                                        permissions:CBAttributePermissionsReadEncryptionRequired];
    
    
    //Start with the CBMutableCharacteristic1
    self.plinta_car_Command_Characteristic = [[CBMutableCharacteristic alloc] initWithType:[CBUUID UUIDWithString:PLINTA_CAR_COMMAND_CHA_UUID]
                                                                                        properties:CBCharacteristicPropertyWrite
                                                                                        value:nil
                                                                                        permissions:CBAttributePermissionsWriteEncryptionRequired];
    
    
    
    
    
    
    
    // Then the service
    CBMutableService *plintaCarService = [[CBMutableService alloc] initWithType:[CBUUID UUIDWithString:PLINTA_CAR_SERVICE_UUID]
                                                                        primary:YES];
    
    
    
    
    
    // Add the characteristic to the service
    plintaCarService.characteristics = @[self.plinta_car_ID_Characteristic,self.plinta_car_Command_Characteristic];
    //plintaCarService.characteristics = @[self.plinta_car_Command_Characteristic];
    
    
    
    // And add it to the peripheral manager
    [self.plinta_car_peripheralManager addService:plintaCarService];
}




/** Catch when someone subscribes to our characteristic, then start sending them data
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didSubscribeToCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"Central subscribed to characteristic");
    
    
}

/** Recognise when the central unsubscribes
 */
- (void)peripheralManager:(CBPeripheralManager *)peripheral central:(CBCentral *)central didUnsubscribeFromCharacteristic:(CBCharacteristic *)characteristic
{
    NSLog(@"Central unsubscribed from characteristic");
}






-(void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveReadRequest:(CBATTRequest *)request{
    NSLog(@"Central received a read request");


    request.value = _myID;
    [self.plinta_car_peripheralManager respondToRequest:(request) withResult:CBATTErrorSuccess];
}

-(void)peripheralManager:(CBPeripheralManager *)peripheral didReceiveWriteRequests:(NSArray *)requests{
    NSLog(@"Central received a write request");

    CBATTRequest *myReq=(CBATTRequest*)[requests objectAtIndex:0];
    
    
    NSLog(@"Data from write request %@",myReq.value);
    
    [self.plinta_car_peripheralManager respondToRequest:[requests objectAtIndex:0] withResult:CBATTErrorSuccess];
    
    
    int value = *(int*)([myReq.value bytes]);
    if (value==0x14) {

        NSLog(@"Wakeup the system");
         }
    
}






@end
