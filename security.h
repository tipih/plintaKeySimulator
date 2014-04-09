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


@end
