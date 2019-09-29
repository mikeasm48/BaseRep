//
//  RestaurantProtocol.h
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 29/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//
//Протокол работы ресторана
@protocol RestaurantProtocol
//Гость делает заказ официанту
- (void) makeOrder;
// Официант относит заказ на кухню
- (void) processOrderToKitchen;
//Кухня передаёт его официанту и он приносит гостю
- (void) deliverOrderToGuest;
//Гость может поблагодарить и оставить чаевые
- (void) payAndGiveTip;
@end
