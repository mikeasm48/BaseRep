//
//  RichGuest.m
//  HomeWorkDelegate
//
//  Created by Михаил Асмаковец on 30/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "RichGuest.h"

@implementation RichGuest: Guest

- (void) decideSatisfied{
    //Happy Path
    [self.delegate payAndGiveTip];
}

@end
