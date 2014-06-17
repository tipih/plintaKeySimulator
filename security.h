//
//  security.h
//  plintaKeySimulator
//
//  Created by Michael Rahr on 09/04/14.
//  Copyright (c) 2014 Plinta Vinnova. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface security : NSObject


+(NSString*) generateKey:(NSString **)mSalt password:(int) password;
+(NSString*) generateKeyWithSalt:(NSString *)mSalt password:(int) password;
+(bool) validtePasswordWithSalt:(NSString *)password salt:(NSString*) mSalt userPassword:(int) userpassword;

@end
