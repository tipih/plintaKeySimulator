//
//  ViewController.m
//  plintaKeySimulator
//
//  Created by Michael Rahr on 04/04/14.
//  Copyright (c) 2014 Plinta Vinnova. All rights reserved.
//

#import "keyViewController.h"
#import "keyBTLEPeripheral.h"
#import <QuartzCore/QuartzCore.h>


@interface keyViewController ()<keyDelegate,UITabBarDelegate>
@property (readonly) keyBTLEPeripheral *plintaKey;


@end



@implementation keyViewController{
     NSArray *animationArray;

}
@synthesize btIndicator;
@synthesize userSelection;
@synthesize key;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Setup the statusbar to be light text
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.userSelection.delegate = self;
    [userSelection setSelectedItem:[userSelection.items objectAtIndex:0]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
    
    _plintaKey = [[keyBTLEPeripheral alloc] initWithClientId:0];
    [_plintaKey setDelegate:self];
    
    
    animationArray=[NSArray arrayWithObjects:
                    [UIImage imageNamed:@"sending_01.png"],
                    [UIImage imageNamed:@"sending_02.png"],
                    [UIImage imageNamed:@"sending_03.png"],
                    [UIImage imageNamed:@"sending_04.png"],
                    nil];
    
    [btIndicator setAnimationImages:animationArray];
    [btIndicator setAnimationDuration:2.0];
    

    
    key.layer.cornerRadius =20;

    

}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSLog(@"%ld", (long)item.tag);
  
    _plintaKey.uiid=(uint)item.tag;
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void) didReceivedReadRequest:(NSUInteger)code{
    //to do update the UI
    NSLog(@"Update the UI");
    [btIndicator stopAnimating];
    [btIndicator setHighlighted:TRUE];
    [self performSelector:@selector(onTimeOut:) withObject:nil afterDelay:1.2];

    
    
}


//Timeout for sending indicator
-(void)onTimeOut:(NSTimer *)timer {

    [btIndicator setHighlighted:FALSE];
    [btIndicator startAnimating];

}


- (IBAction)startAdvertize:(UISwitch*)sender {
    if (sender.isOn) {
        _plintaKey.broardcast=TRUE;
        [btIndicator startAnimating];
           [self.key startPulseWithColor:[UIColor blueColor] offset:CGSizeMake(3.2, 3.2) frequency:2];
    }
    else
    {
    _plintaKey.broardcast=FALSE;
        [btIndicator stopAnimating];
        [self.key stopPulseEffect];
    }
}

@end
