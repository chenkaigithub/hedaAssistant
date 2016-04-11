//
//  LessonDeatilHeader.m
//  hedaAssistant
//
//  Created by bear on 16/4/9.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "LessonDeatilHeader.h"


@interface LessonDeatilHeader ()


@end

@implementation LessonDeatilHeader




-(void)awakeFromNib{


    self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_background"]];
    self.layer.shadowOffset=CGSizeMake(0, 2);
    self.layer.shadowOpacity=0.2;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
