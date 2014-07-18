//
//  UIView+DrawRectBlock.m
//  TestDrawRect
//
//  Created by mhergon on 20/06/14.
//  Copyright (c) 2014 mhergon. All rights reserved.
//

#import "UIView+DrawBlock.h"

@implementation UIView (DrawBlock)

- (void)drawInside:(DrawBlock)block withResult:(CompletionBlock)completion {
    
    if (block) {

        // Add subview
        UIImageView *drawView = [[UIImageView alloc] init];
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
        [self setNeedsLayout];
        
        // Draw
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        block(context, self.bounds);
        drawView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (completion) {
            completion(drawView);
        }
        
    }

}

@end
