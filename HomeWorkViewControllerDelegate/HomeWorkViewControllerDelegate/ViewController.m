//
//  ViewController.m
//  HomeWorkViewControllerDelegate
//
//  Created by Михаил Асмаковец on 17.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.view.backgroundColor = [UIColor cyanColor];
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"Назад" forState:UIControlStateNormal];
        _button.backgroundColor = [UIColor whiteColor];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self
                    action:@selector(tapButton)
          forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:_button];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.button.frame = CGRectMake(25.0, 150.0, 100.0, 40.0);
}

- (void)tapButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
