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
    
    FractalView *v = [[FractalView alloc] init];
    [self.view addSubview:v];
    
    //
    // Layout
    //
    NSDictionary *views = @{@"v": v};
    
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-0-[v]-0-|"
        options:0 metrics:nil views:views
    ]];
    [NSLayoutConstraint activateConstraints:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:|-0-[v]-0-|"
        options:0 metrics:nil views:views
    ]];
}


@end
