//
//  ViewController.h
//  plintaKeySimulator
//
//  Created by Michael Rahr on 04/04/14.
//  Copyright (c) 2014 Plinta Vinnova. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+ZKPulseView.h"

@interface keyViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *advartize;

@property (weak, nonatomic) IBOutlet UIImageView *btIndicator;


@property (weak, nonatomic) IBOutlet UIImageView *key;
@property (weak, nonatomic) IBOutlet UITabBar *userSelection;
@end
