//
//  Waitor.m
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 29/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "Waiter.h"

@implementation Waiter

- (void) getOrder{
    [self.delegate processOrderToKitchen];
}

- (void) completeOrder{
    [self.delegate payAndGiveTip];
}
@end
