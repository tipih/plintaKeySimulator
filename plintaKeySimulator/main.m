//
//  main.m
//  plintaKeySimulator
//
//  Created by Michael Rahr on 04/04/14.
//  Copyright (c) 2014 Plinta Vinnova. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool {
        UILocalNotification* localNotification = [[UILocalNotification alloc] init];
        
        localNotification.alertBody = @"Will still send key signal";
        localNotification.alertAction = @"Show me the item";
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }

    
    //[UIApplication presentLocalNotificationNow:localNotification];
}
