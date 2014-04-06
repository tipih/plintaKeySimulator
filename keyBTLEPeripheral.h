//
//  keyBTLEPeripheral.h
//  plintaKeySimulator
//
//  Created by Michael Rahr on 04/04/14.
//  Copyright (c) 2014 Plinta Vinnova. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol keyDelegate <NSObject>

//Must implement,
@required
- (void) didReceivedReadRequest: (NSUInteger)code;


@end

@interface keyBTLEPeripheral : NSObject
{
    // Delegate to respond back
    id <keyDelegate> _delegate;
}

@property (nonatomic,strong) id delegate;
@property (nonatomic) uint password;
@property (nonatomic) uint uiid;
@property (nonatomic) bool broardcast;
- (keyBTLEPeripheral*) initWithClientId: (uint)clientId;

@end
