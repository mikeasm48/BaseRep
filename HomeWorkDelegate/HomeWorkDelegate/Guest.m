//
//  Guest.m
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 29/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "Guest.h"

@implementation Guest

- (void)visitRestaurant { 
    [self.delegate makeOrder];
}

- (void) decideSatisfied{
    //Happy Path
    [self.delegate payAndGiveTip];
}
@end
