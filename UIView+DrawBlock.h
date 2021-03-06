//
//  UIView+DrawRectBlock.h
//  TestDrawRect
//
//  Created by mhergon on 20/06/14.
//  Copyright (c) 2014 mhergon. All rights reserved.
//

#import <UIKit/UIKit.h>

// Blocks
typedef void(^DrawBlock)(CGContextRef context, CGRect drawFrame);
typedef void(^CompletionBlock)(UIView *view);

@interface UIView (DrawBlock)
- (void)drawInside:(DrawBlock)block withResult:(CompletionBlock)completion;

@end
