//
//  FractalView.m
//  Fractial tree
//
//  Created by Dax Rahusen on 16/10/2017.
//  Copyright © 2017 Dax. All rights reserved.
//

#import "FractalView.h"

@implementation FractalView
{
    UILabel *_timeLabel;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.backgroundColor = [UIColor clearColor];
        self.contentMode = UIViewContentModeRedraw;
        
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _timeLabel.font = [UIFont boldSystemFontOfSize:20];
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.text = @"Year 0";
        [self addSubview:_timeLabel];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.translatesAutoresizingMaskIntoConstraints = NO;
        lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:lineView];
        
        //
        // Layout
        //
        NSDictionary *views = NSDictionaryOfVariableBindings(_timeLabel);
        
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"H:|-20-[_timeLabel]"
            options:0 metrics:nil views:views
        ]];
        [NSLayoutConstraint activateConstraints:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:|-40-[_timeLabel]"
            options:0 metrics:nil views:views
        ]];
        
        [NSLayoutConstraint activateConstraints:@[
            [lineView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
            [lineView.rightAnchor constraintEqualToAnchor:self.rightAnchor],
            [lineView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [lineView.heightAnchor constraintEqualToConstant:2]
        ]];
    }
    return self;
}

- (void)updateUI {
    
    _timeLabel.text = [NSString stringWithFormat:@"Year %.f", _level];
    
    [self setNeedsDisplay];
}

- (void)setLevel:(CGFloat)level {
    if (_level != level) {
        _level = level;
        [self updateUI];
    }
}

- (void)drawRect:(CGRect)rect {
    
    [[UIColor blackColor] set];
    
    CGRect b = UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(10, 10, 0, 10));
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 2);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(b), CGRectGetMaxY(b));
  
    [self
        drawBrancheWithContext:c
        startPoint:startPoint
        level:_level
        length:b.size.width / 6
        angle:M_PI + M_PI_2
    ];
    
    CGContextStrokePath(c);
}

- (void)drawBrancheWithContext:(CGContextRef)context
    startPoint:(CGPoint)startPoint
    level:(NSInteger)level
    length:(CGFloat)length
    angle:(CGFloat)angle
{
    if (level < 1) {
        return;
    }
    
    NSInteger l = level -= 1;
    
    CGPoint endPoint = CGPointMake(
        startPoint.x + cosf(angle) * length,
        startPoint.y + sinf(angle) * length
    );
    
    // draw root
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(
        context,
        endPoint.x,
        endPoint.y
    );
    
    [self
         drawBrancheWithContext:context
         startPoint:endPoint
         level:l
         length:length * .8
         angle:angle - M_PI_4 / 2
     ];

    [self
        drawBrancheWithContext:context
        startPoint:endPoint
        level:l
        length:length * .8
        angle:angle + M_PI_4 / 2
    ];
}

@end
