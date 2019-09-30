//
//  Guest.h
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 29/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestaurantProtocol.h"
#import "GuestProtocol.h"
//Гость в ресторане
@interface Guest : NSObject <GuestProtocol>

@property (nonatomic, weak) id <RestaurantProtocol> delegate;

- (void) visitRestaurant;

- (void) decideSatisfied;

@end

