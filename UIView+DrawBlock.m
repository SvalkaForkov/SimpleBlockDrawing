//
//  UIView+DrawRectBlock.m
//  TestDrawRect
//
//  Created by mhergon on 25/02/14.
//  Copyright (c) 2014 mhergon. All rights reserved.
//

#import "UIView+DrawBlock.h"
#import <objc/runtime.h>

#pragma mark - Auxiliar view
@interface DrawingView : UIView
@property (weak, nonatomic, setter = setDrawRectBlock:) DrawBlock drawBlock;
- (void)setDrawRectBlock:(DrawBlock)block;
@end

@implementation DrawingView
- (void)setDrawRectBlock:(DrawBlock)block {
    if (_drawBlock = [block copy]) {
        [self setNeedsDisplay];
    }
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (_drawBlock != nil) {
        _drawBlock(context, rect);
    }
    _drawBlock = nil;
}
@end

#pragma mark - Category
@implementation UIView (DrawBlock)
- (void)drawInside:(DrawBlock)block withResult:(CompletionBlock)completion {
    if (block != nil) {
        DrawingView *drawView = [[DrawingView alloc] init];
        drawView.drawBlock = block;
        drawView.translatesAutoresizingMaskIntoConstraints = NO;
        drawView.userInteractionEnabled = NO;
        drawView.backgroundColor = [UIColor clearColor];
        [self addSubview:drawView];
        
        NSDictionary *views = NSDictionaryOfVariableBindings(drawView);
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[drawView]|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:views];
        [self addConstraints:constraints];
        constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[drawView]|"
                                                              options:0
                                                              metrics:nil
                                                                views:views];
        [self addConstraints:constraints];

        if (completion != nil) {
            completion(drawView);
        }
    }
}

#pragma mark - Others
- (void)setDrawBlock:(DrawBlock)drawBlock {
    objc_setAssociatedObject(self, @"block", drawBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (DrawBlock)drawBlock {
    return objc_getAssociatedObject(self, @"block");
}

@end
