//
//  Work1.m
//  HomeWork
//
//  Created by Михаил Асмаковец on 26/09/2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "Work1.h"

@implementation Work1

//Сортировка вставками
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
    //1. Есть массив чисел 3, 6, 32, 24, 81.
    NSMutableArray *arrayToSort = [NSMutableArray arrayWithObjects:@(3), @(6), @(32), @(24),@(81), nil];
    NSLog(@"Задание 1. Исходный массив: %@",arrayToSort);
    //1.1. Отсортируйте этот массив по возрастанию.
    [self insertionSort: arrayToSort inverse:NO];
    NSLog(@"Сортированный массив по возрастанию: %@",arrayToSort);
    //1.2. Сделайте с помощью цикла массив, содержащий числа, большие чем 20.
    NSMutableArray *arrayToExercise = [NSMutableArray new];
    for (NSNumber *element in arrayToSort) {
        int valueInt = [element intValue];
        if ( valueInt > 20){
            [arrayToExercise addObject:element];
        }
    }
     NSLog(@"Массив со значениями больше 20: %@",arrayToExercise);
    
    //1.3. Сделайте с помощью цикла массив, содержащий только кратные трём числа.
    for (NSNumber *element in arrayToSort) {
        int valueInt = [element intValue];
        int div3 = valueInt/3;
        if (div3*3 == valueInt){
            [arrayToExercise addObject:element];
        }
    }
    NSLog(@"Добавил в предыдущий все кратные трем: %@",arrayToExercise);
    //1.4. Добавьте этот массив в исходный.
    [arrayToSort addObjectsFromArray:arrayToExercise];
    NSLog(@"Добавил общий результат в исходный отсортированый %@",arrayToSort);
    //1.5. Отсортируйте его по убыванию.
    [self insertionSort: arrayToSort inverse:YES];
    NSLog(@"Итого: все отсортировано по убыванию %@",arrayToSort);
    
    //2. Есть массив строк: "cataclism", "catepillar", "cat", "teapot", "truncate".
    NSArray *strArray = @[@"cataclism",@"teapot",@"catepillar", @"cat",@"teapot",@"truncate"];
    NSLog(@"Задание 2. Исходный массив строк %@",strArray);
    //2.1. Отфильтруйте так, чтобы остались только строки с префиксом "cat" (Поможет метод строки hasPrefix) с помощью NSPredicate.
    NSPredicate *catStart = [NSPredicate predicateWithFormat:@"SELF beginswith[s] 'cat'"];
    NSArray *catArray = [strArray filteredArrayUsingPredicate:catStart];
    //2.2. Полученный массив выведите в консоль.
    NSLog(@"Отфильтрованый массив строк (начинаются с cat) %@",catArray);
    //2.3. Сделайте из полученного массива словарь, содержащий пары слово - количество букв в нём.
    NSMutableDictionary *catDic = [NSMutableDictionary new];
    
    for (NSString *cat in catArray) {
        NSNumber *len = [NSNumber numberWithLong:cat.length];
        [catDic setObject: len forKey:cat];
    }
    NSLog(@"словарь, содержащий пары слово - количество букв в нём%@",catDic);
}
@end
