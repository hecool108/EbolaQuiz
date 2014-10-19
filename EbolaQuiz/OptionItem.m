//
//  OptionItem.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-13.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "OptionItem.h"
#import "UIGenerator.h"
#import "Pop.h"
#import "BlocksKit.h"
@interface OptionItem(){
    UILabel *optionLabel;
    UIButton *theButton;
    UIImageView *imageView;
}
@end
@implementation OptionItem
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        optionLabel = [UIGenerator createSystemLabel:CGRectMake(20, 0, 280, 50) size:20
                                               color:[UIColor colorWithRed:0.565 green:0.906 blue:0.776 alpha:1]
                                               align:NSTextAlignmentLeft];
        [self addSubview:optionLabel];
        self.alpha = 0;
        theButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGRect theFrame = optionLabel.frame;
    theFrame.size.width += 20;
    theFrame.origin.x -= 20;
    CGContextAddRect(context, theFrame);
    CGContextSetLineWidth(context, 2);
    CGContextStrokePath(context);
}
-(void)updateData:(OptionObject *)option{
    _optionObj = option;
    POPSpringAnimation *animationFadeOut = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    animationFadeOut.fromValue = @(1);
    animationFadeOut.toValue = @(0);
    [self.layer pop_addAnimation:animationFadeOut forKey:@"fadeOut"];
    [NSTimer bk_performBlock:^{
        if (_optionObj) {
            self.alpha = 0;
            [self setHidden:NO];
            optionLabel.text = _optionObj.statement;
            optionLabel.frame = CGRectMake(optionLabel.frame.origin.x, optionLabel.frame.origin.y, 280, 0);
            optionLabel.lineBreakMode = NSLineBreakByWordWrapping;
            optionLabel.numberOfLines = 0;
            [optionLabel sizeToFit];
            self.hTo = 0;
            if (![_optionObj.statement isEqualToString:@""]) {
                self.hTo = optionLabel.frame.size.height + 20;
                optionLabel.frame = CGRectMake(optionLabel.frame.origin.x, (self.hTo - optionLabel.frame.size.height)/2, optionLabel.frame.size.width, optionLabel.frame.size.height);
            }
            
            if (imageView != nil) {
                [imageView removeFromSuperview];
                imageView = nil;
            }
            CGRect imageFrame = imageView.frame;
            imageFrame.origin.x = 20;
            imageFrame.origin.y = self.hTo;
            
            if (![_optionObj.imageName isEqualToString:@""]) {
                imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_optionObj.imageName]];
                imageView.frame = CGRectMake(20, 10, imageView.image.size.width, imageView.image.size.height);
                [self addSubview:imageView];
                self.hTo += imageView.image.size.height + 20;
            }else
            {
                imageView.image = nil;
            }
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.hTo);
            POPSpringAnimation *animationFadeIn = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            animationFadeIn.fromValue = @(0.0);
            animationFadeIn.toValue = @(1.0);
            animationFadeIn.springBounciness = 10;
            [self.layer pop_addAnimation:animationFadeIn forKey:@"fadeIn"];
        }else
        {
            [self setHidden:YES];
        }
    } afterDelay:0.2];
}
@end
