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

@property (copy, nonatomic) DrawBlock drawBlock;

- (void)setDrawRectBlock:(DrawBlock)block;

@end

@implementation DrawingView
- (void)setDrawRectBlock:(DrawBlock)block {
    if((_drawBlock = [block copy])) {
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect {
    if(_drawBlock) {
        _drawBlock(UIGraphicsGetCurrentContext());
    }
}

@end

#pragma mark - Category
@interface UIView ()

@property DrawBlock drawBlock;

@end

@implementation UIView (DrawBlock)

- (void)drawInside:(DrawBlock)block withResult:(CompletionBlock)completion {
    if ((self.drawBlock = [block copy])) {
        DrawingView *drawView = [[DrawingView alloc] initWithFrame:self.bounds];
        drawView.backgroundColor = [UIColor clearColor];
        [drawView setDrawRectBlock:self.drawBlock];
        [self addSubview:drawView];
        if (completion != NULL) {
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
