//
//  UIView+DrawRectBlock.m
//  TestDrawRect
//
//  Created by mhergon on 20/06/14.
//  Copyright (c) 2014 mhergon. All rights reserved.
//

#import "UIView+DrawBlock.h"

#pragma mark - Auxiliar view
@interface DrawingView : UIView
@property (strong, nonatomic) DrawBlock drawBlock;
- (void)setDrawRectBlock:(DrawBlock)block;
@end

@implementation DrawingView
- (void)setDrawRectBlock:(DrawBlock)block {
    _drawBlock = block;
    if (_drawBlock) {
        [self setNeedsDisplay];
    }
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (_drawBlock) {
        _drawBlock(context, rect);
        _drawBlock = nil;
    }

}
@end

#pragma mark - Category
@implementation UIView (DrawBlock)
- (void)drawInside:(DrawBlock)block withResult:(CompletionBlock)completion {
    if (block) {
        DrawingView *drawView = [[DrawingView alloc] init];
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
        [drawView setDrawRectBlock:block];
        
        if (completion != nil) {
            completion(drawView);
        }
    }
}

@end
