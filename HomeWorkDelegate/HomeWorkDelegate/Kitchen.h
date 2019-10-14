//
//  Kitchen.h
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 29/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RestaurantProtocol.h"

//Кухня
@interface Kitchen : NSObject
//Делегат: протокол ресторана
@property (nonatomic, weak) id <RestaurantProtocol> delegate;
//Начало приготовления блюда
- (void) startCooking;
@end


