//
//  ViewController.m
//  Fractial tree
//
//  Created by Dax Rahusen on 16/10/2017.
//  Copyright © 2017 Dax. All rights reserved.
//

#import "ViewController.h"

#import "FractalView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    FractalView *_v;
}

- (instancetype)init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _v = [[FractalView alloc] init];
    [self.view addSubview:_v];
    
    UISlider *slider = [[UISlider alloc] init];
    slider.translatesAutoresizingMaskIntoConstraints = NO;
    [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    slider.tintColor = [UIColor blackColor];
    slider.minimumValue = 0;
    slider.maximumValue = 12;
    slider.value = 0;
    [self.view addSubview:slider];
    
    //
    // Layout
    //
    NSDictionary *views = NSDictionaryOfVariableBindings(_v, slider);
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-0-[_v]-0-|"
        options:0 metrics:nil views:views
    ]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:|-0-[_v]-20-[slider]-20-|"
        options:0 metrics:nil views:views
    ]];
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-20-[slider]-20-|"
        options:0 metrics:nil views:views
    ]];
}

- (void)sliderValueChanged:(UISlider *)sender {
    NSLog(@"%f", roundf(sender.value));
    _v.level = roundf(sender.value);
}


@end
