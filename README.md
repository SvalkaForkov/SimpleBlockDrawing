SimpleBlockDrawing
=================================

Category for drawing on UIView with a simplest way


## Usage ##

Import 
```objective-c
    #import "UIView+DrawBlock.h" 
```
    
Use it! Result block returns a UIView added to original view with  the drawing.
```objective-c

    [self.viewToDraw drawInside:^(CGContextRef context) {
        
        // Draw
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetLineWidth(context, 5.0);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0.0, 0.0);
        CGContextAddLineToPoint(context, 100.0, 100.0);
        CGContextStrokePath(context);
        
    } withResult:^(UIView *view) {
        
        // Do what you want!
        
    }];
```                               


## Requirements ##
Requires Xcode 5, targeting either iOS 6.0 and above

## Contact ##

 - [Marc Hervera][2] ([@mhergon][3])

  [2]: http://github.com/mhergon "Marc Hervera"
  [3]: http://twitter.com/mhergon "Marc Hervera"


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/mhergon/simpleblockdrawing/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

