//
//  MyViewControllerDelegate.m
//  HomeWorkViewControllerDelegate
//
//  Created by Михаил Асмаковец on 17.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "MyViewControllerDelegate.h"


@implementation MyViewControllerDelegate


- (void) navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"Отображается класс контроллера: %@",viewController.class);
}
@end
