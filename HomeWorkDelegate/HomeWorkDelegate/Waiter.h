//
//  Waitor.h
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 29/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "RestaurantProtocol.h"

//Официант
@interface Waiter : NSObject

@property (nonatomic, weak) id <RestaurantProtocol> delegate;

- (void) getOrder;

- (void) completeOrder;

@end



