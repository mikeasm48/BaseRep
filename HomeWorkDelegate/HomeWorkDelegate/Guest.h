//
//  Guest.h
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 29/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantProtocol.h"

//Гость в ресторане
@interface Guest : NSObject
//Делегат: протокол ресторана
@property (nonatomic, weak) id <RestaurantProtocol> delegate;

//Посетить ресторан
- (void) visit: (id <RestaurantProtocol>) restaurant;

//Принять решение об оплате: с чаевыми или без
- (void) decideSatisfied;

@end

