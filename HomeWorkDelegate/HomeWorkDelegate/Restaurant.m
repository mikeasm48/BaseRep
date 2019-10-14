//
//  Restaurant.m
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 14.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "Restaurant.h"
#import "RestaurantProtocol.h"
#import "Guest.h"
#import "RichGuest.h"
#import "Waiter.h"
#import "Kitchen.h"


//Ресторан
@interface Restaurant() <RestaurantProtocol>
@property (nonatomic, strong) Guest *guest;
@property (nonatomic, strong) Waiter *waiter;
@property (nonatomic, strong) Kitchen *kitchen;
@end

@implementation Restaurant

- (instancetype)init: (Guest*) withGuest
{
    self = [super init];
    if (self) {
        self.guest = withGuest;
        self.waiter = [[Waiter alloc] init];
        self.waiter.delegate = self;
        self.kitchen = [[Kitchen alloc] init];
        self.kitchen.delegate = self;
    }
    return self;
}

- (void)makeOrder {
    NSLog(@"Гость делает заказ");
    [self.waiter getOrder];
}

- (void)processOrderToKitchen {
    NSLog(@"Официант доставляет заказ на кухню");
    [self.kitchen startCooking];
}

- (void)deliverOrderToGuest {
    NSLog(@"Официант доставляет заказ клиенту");
    [self.waiter completeOrder];
}

- (void) decideForPayment {
    NSLog(@"Гость получает заказ");
    [self.guest decideSatisfied];
}

- (void) payAndGiveTip {
    NSLog(@"Гость уходит, благодарит и оставляет чаевые");
}

- (void) payAndGiveNoTip {
    NSLog(@"Гость уходит не оставляет чаевые");
}

@end
