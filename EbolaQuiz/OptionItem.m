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
@interface OptionItem(){
    UILabel *optionLabel;
    UIButton *theButton;
}
@end
@implementation OptionItem
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        optionLabel = [UIGenerator createSystemLabel:CGRectMake(20, 0, 280, 50) size:20
                                               color:[UIColor blackColor] align:NSTextAlignmentLeft];
        [self addSubview:optionLabel];
        self.alpha = 0;
        theButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return self;
}
-(void)drawRect:(CGRect)rect{
    self.backgroundColor = [UIColor grayColor];
}
-(void)updateData:(OptionObject *)option{
    _optionObj = option;
    POPSpringAnimation *animationFadeOut = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    animationFadeOut.toValue = @(0);
    animationFadeOut.springBounciness = 10;
    [animationFadeOut setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        if (_optionObj) {
            [self setHidden:NO];
            optionLabel.text = _optionObj.statement;
            POPSpringAnimation *animationFadeIn = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
            animationFadeIn.fromValue = @(0.0);
            animationFadeIn.toValue = @(1.0);
            animationFadeIn.springBounciness = 10;
            [self.layer pop_addAnimation:animationFadeIn forKey:@"fadeIn"];
        }else
        {
            [self setHidden:YES];
        }
    }];
    [self.layer pop_addAnimation:animationFadeOut forKey:@"fadeOut"];
}
@end
