//
//  Work1.m
//  HomeWork
//
//  Created by Михаил Асмаковец on 26/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "Work1.h"

@implementation Work1

+ (void) insertionSort: (NSMutableArray*) arrayToSort inverse: (BOOL) needInverse{
    for (int i = 1; i<arrayToSort.count; i++) {
        for (int j = i; j>0; j--) {
            int valPrevious = [arrayToSort[j-1] intValue];
            int valCurrent = [arrayToSort[j] intValue];
            BOOL compare;
            if (needInverse){
                compare = (valPrevious < valCurrent);
            } else {
                compare = (valPrevious > valCurrent);
            }
            if (compare) {
                NSNumber *tmp = arrayToSort[j-1];
                arrayToSort[j-1] = arrayToSort[j];
                arrayToSort[j] = tmp;
            }
        }
    }
}

+ (void) arraysSort{
    //Сортировка вставками
    NSMutableArray *arrayToSort = [NSMutableArray arrayWithObjects:@(3), @(6), @(32), @(24),@(81), nil];
    NSLog(@"Исходный массив: %@",arrayToSort);
    [self insertionSort: arrayToSort inverse:NO];
    NSLog(@"Сортированный массив по возрастанию: %@",arrayToSort);
   
    [self insertionSort: arrayToSort inverse:YES];
    NSLog(@"Сортированный массив по убыванию: %@",arrayToSort);
}
@end
