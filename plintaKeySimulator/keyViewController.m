//
//  ViewController.m
//  plintaKeySimulator
//
//  Created by Michael Rahr on 04/04/14.
//  Copyright (c) 2014 Plinta Vinnova. All rights reserved.
//

#import "keyViewController.h"
#import "keyBTLEPeripheral.h"

@interface keyViewController ()<keyDelegate>
@property (readonly) keyBTLEPeripheral *plintaKey;

@end

@implementation keyViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Setup the statusbar to be light text
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    _plintaKey = [[keyBTLEPeripheral alloc] initWithClientId:1];
    [_plintaKey setDelegate:self];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) didReceivedReadRequest:(NSUInteger)code{
    //to do update the UI
    NSLog(@"Update the UI");
}
- (IBAction)startAdvertize:(UISwitch*)sender {
    if (sender.isOn) {
        _plintaKey.broardcast=TRUE;
    }
    else
    _plintaKey.broardcast=FALSE;
}

@end
