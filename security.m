//
//  security.m
//  plintaKeySimulator
//
//  Created by Michael Rahr on 09/04/14.
//  Copyright (c) 2014 Plinta Vinnova. All rights reserved.
//

#import "security.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation security


+(NSUInteger)GenerateSalt
{
    // random number (change the modulus to the length you'd like)
    NSUInteger r = arc4random() % 1;
    return r;
}


+(NSString*) generateKey:(NSString **)mSalt password:(int) password{
    
  
    NSString* mLocalStringSalt = [NSString stringWithFormat:@"%ld", [self GenerateSalt]];
    
    mLocalStringSalt=[self computeSHA256DigestForString:mLocalStringSalt];
    *mSalt=mLocalStringSalt;
    NSLog(@"Salt =%@",mLocalStringSalt);
    
    
    NSString* mPass=[self computeSHA256DigestForString:[NSString stringWithFormat:@"%d", password]];
    NSLog(@"mPass =%@",mPass);
    
    NSString *computedHashString = [NSString stringWithFormat:@"%@%@", mPass, mLocalStringSalt];
    NSLog(@"Hash string %@",computedHashString);
    mPass=[self computeSHA256DigestForString:computedHashString];
    NSLog(@"final key %@",mPass);
    
    
    return mPass;
}



// This is where the rest of the magic happens.
// Here we are taking in our string hash, placing that inside of a C Char Array, then parsing it through the SHA256 encryption method.
+ (NSString*)computeSHA256DigestForString:(NSString*)input
{
    
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    // This is an iOS5-specific method.
    // It takes in the data, how much data, and then output format, which in this case is an int array.
    CC_SHA256(data.bytes, data.length, digest);
    
    // Setup our Objective-C output.
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    // Parse through the CC_SHA256 results (stored inside of digest[]).
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}


+(NSString*) generateKeyWithSalt:(NSString *)mSalt password:(int) password{
    
    NSString* mPass=[self computeSHA256DigestForString:[NSString stringWithFormat:@"%d", password]];
    NSLog(@"mPass =%@",mPass);
    
    NSString *computedHashString = [NSString stringWithFormat:@"%@%@", mPass, mSalt];
    NSLog(@"Hash string %@",computedHashString);
    mPass=[self computeSHA256DigestForString:computedHashString];
    NSLog(@"final key %@",mPass);
    
    
    return mPass;
}


//Validate a password with a salt and a localpassword
+ (bool)validtePasswordWithSalt:(NSString *)password salt:(NSString *)mSalt userPassword:(int)userpassword{
    
    
    NSLog(@"Password %@",password);
    NSString* encodedPassword=[self generateKeyWithSalt:mSalt password:userpassword];
    
    if ([encodedPassword isEqualToString:password])
    {
        return true;
    }
    else
        NSLog(@"Wrong passeword");
    
    
    
    return true;
}


@end
