//
//  RootViewController.m
//  HomeWorkViewControllerDelegate
//
//  Created by Михаил Асмаковец on 17.10.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) ViewController *viewController;

@end

@implementation RootViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _viewController = [ViewController new];
        
        [self setUpButton];
    }
    return self;
}

- (void)setUpButton
{
    _button = [UIButton new];
    [_button setTitle:@"Привет!" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _button.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_button];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor redColor];
    
    CGRect myRect = self.view.frame;
    
    self.button.frame = CGRectMake(CGRectGetMidX(myRect),
                                   CGRectGetMidY(myRect),
                                   100.0,
                                   40.0);
    [self.button addTarget:self
                    action:@selector(tapButton)
          forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:self.button];
    //self.view addSubview:
}


- (void)tapButton
{
    [self.navigationController pushViewController:self.viewController
                                         animated:TRUE];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
