//
//  Restaurant.h
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 14.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Guest.h"

//Ресторан
@interface Restaurant <RestaurantProtocol> : NSObject

- (instancetype)init: (Guest*) withGuest;

@end

