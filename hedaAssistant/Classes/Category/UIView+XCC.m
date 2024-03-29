//
//  UIView+XCC.m
//  hedaAssistant
//
//  Created by bear on 16/4/3.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "UIView+XCC.h"

@implementation UIView (XCC)

-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x{
    CGRect rect=self.frame;
    rect.origin.x=x;
    self.frame=rect;
}



-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y{
    CGRect rect=self.frame;
    rect.origin.y=y;
    self.frame=rect;

}


-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width{
    CGRect rect=self.frame;
    rect.size.width=width;
    self.frame=rect;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height{
    CGRect rect=self.frame;
    rect.size.height=height;
    self.frame=rect;
}


@end
