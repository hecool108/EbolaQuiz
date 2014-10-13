//
//  UIGenerator.m
//  iyuesairunning
//
//  Created by 王贺 on 14-10-9.
//  Copyright (c) 2014年 wisdom-china. All rights reserved.
//

#import "UIGenerator.h"

@implementation UIGenerator
+(UILabel *)createSystemLabel:(CGRect)theRect size:(float)size color:(UIColor *)color{
    UILabel *theLabel = [[UILabel alloc] initWithFrame:theRect];
    [theLabel setTextColor:color];
    theLabel.textAlignment = NSTextAlignmentLeft;
    [theLabel setFont:[UIFont systemFontOfSize:size]];
    return theLabel;
}
+(UILabel *)createSystemLabel:(CGRect)theRect size:(float)size color:(UIColor *)color align:(NSTextAlignment)align{
    UILabel *theLabel = [[UILabel alloc] initWithFrame:theRect];
    [theLabel setTextColor:color];
    theLabel.textAlignment = align;
    [theLabel setFont:[UIFont systemFontOfSize:size]];
    return theLabel;
}
+(UILabel *)labelWithRect:(CGRect)rect andColor:(UIColor *)color andAlign:(NSTextAlignment)align{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rect.size.width,rect.size.height)];
    [textLabel setTextColor:color];
    textLabel.textAlignment = align;
    [textLabel setFrame:rect];
    [textLabel setBounds:rect];
    return textLabel;
}
@end
