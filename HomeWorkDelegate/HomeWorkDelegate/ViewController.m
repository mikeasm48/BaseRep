//
//  ViewController.m
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 29/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "ViewController.h"
#import "RestaurantProtocol.h"
#import "Guest.h"
#import "RichGuest.h"
#import "Waiter.h"
#import "Kitchen.h"

@interface ViewController () <RestaurantProtocol>
@property (nonatomic, strong) Guest *guest;
@property (nonatomic, strong) Waiter *waiter;
@property (nonatomic, strong) Kitchen *kitchen;
@end

@implementation ViewController

- (BOOL) randomBool {
    int i = arc4random()%2;
    return i == 1;
}
- (void)viewDidLoad {
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
    
    self.guest.delegate = self;
    self.waiter = [[Waiter alloc] init];
    self.waiter.delegate = self;
    self.kitchen = [[Kitchen alloc] init];
    self.kitchen.delegate = self;
    
    [self.guest visitRestaurant];
}

- (void)makeOrder {

    NSLog(@"Гость делает заказ");
    [self.waiter getOrder];
}

- (void)processOrderToKitchen {
    NSLog(@"Официант доставляет заказ на кухну");
    [self.kitchen startCooking];
}

- (void)deliverOrderToGuest {
    NSLog(@"Официант доставляет заказ клиенту");
    [self.waiter completeOrder];
}

- (void) payAndGiveTip {
    NSLog(@"Гость уходит");
    if ([self.guest respondsToSelector:@selector(payTip)]){
        [self.guest payTip];
    } else {
        NSLog(@"и не оставляет чаевые");
    }
    NSLog(@"Сценарий завершен");
}

@end
