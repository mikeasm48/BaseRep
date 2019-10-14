//
//  ViewController.m
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 29/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "ViewController.h"
#import "Guest.h"
#import "RichGuest.h"
#import "Restaurant.h"


@interface ViewController ()
@property (nonatomic, strong) Guest *guest;
@property (nonatomic, strong) Restaurant<RestaurantProtocol> *restaurant;
@end

@implementation ViewController

- (BOOL) randomBool {
    int i = arc4random()%2;
    return i == 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    NSLog(@"Начало сценария");
    
    if ([self randomBool] )
    {
        NSLog(@"Пришел RichGuest");
        self.guest = [[RichGuest alloc] init];
    }else
    {
        NSLog(@"Пришел Guest");
       self.guest = [[Guest alloc] init];
    }
    
    self.restaurant = [[Restaurant<RestaurantProtocol> alloc] init: self.guest];
    [self.guest visit: self.restaurant];
    
    NSLog(@"Сценарий завершен");
}

@end
