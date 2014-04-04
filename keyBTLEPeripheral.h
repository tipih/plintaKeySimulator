//
//  keyBTLEPeripheral.h
//  plintaKeySimulator
//
//  Created by Michael Rahr on 04/04/14.
//  Copyright (c) 2014 Plinta Vinnova. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface keyBTLEPeripheral : NSObject
@property (nonatomic) uint password;
@property (nonatomic) uint uiid;


- (keyBTLEPeripheral*) initWithClientId: (uint)clientId;
@end
