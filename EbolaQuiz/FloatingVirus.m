//
//  FloatingVirus.m
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/19.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "FloatingVirus.h"
#import "Pop.h"
#import <BlocksKit/BlocksKit.h>
@interface FloatingVirus(){
    CGRect theRect;
    NSTimer *completeTimer;
    BOOL toStop;
}
@end
@implementation FloatingVirus

- (id)initWithVirusType:(int)type rect:(CGRect)rect
{
    theRect = rect;
    toStop = NO;
    self = [super initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"virus%d",type]]];
    if (self) {
        CGPoint startPoint = CGPointMake(arc4random_uniform(rect.size.width), arc4random_uniform(rect.size.height));
        CGRect theFrame = self.frame;
        theFrame.origin.x = startPoint.x;
        theFrame.origin.y = startPoint.y;
        self.frame = theFrame;
        float rotationTo = M_2_PI * (arc4random_uniform(100)/100.0);
        self.transform = CGAffineTransformMakeRotation(rotationTo);
        self.alpha = 0;
    }
    return self;
}
- (void)stopCompleteTimer {
    if (completeTimer) {
        [completeTimer invalidate];
        completeTimer = nil;
    }
}

-(void)start{
    NSTimeInterval timeToUse = 5 + arc4random_uniform(10);
    CGPoint toPoint = CGPointMake(arc4random_uniform(theRect.size.width), arc4random_uniform(theRect.size.height));
    POPBasicAnimation *animationMove = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    animationMove.duration = timeToUse;
    animationMove.toValue = [NSValue valueWithCGPoint:toPoint];
    [self.layer pop_addAnimation:animationMove forKey:@"animationMove"];
    
    POPBasicAnimation *animationAppear = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    animationAppear.toValue = @(0.4);
    animationAppear.duration = 5;
    [self.layer pop_addAnimation:animationAppear forKey:@"animationAppear"];
    
    float rotationTo = M_2_PI * (arc4random_uniform(100)/100.0);
    POPBasicAnimation *animationRotation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    animationRotation.toValue = @(rotationTo);
    animationRotation.duration = timeToUse;
    [self.layer pop_addAnimation:animationRotation forKey:@"animationRotation"];
    if (!toStop) {
        __weak FloatingVirus *theSelf = self;
        completeTimer = [NSTimer bk_performBlock:^{
            [theSelf start];
        } afterDelay:timeToUse];
    }else
    {
        [self.layer pop_removeAllAnimations];
    }
}
-(void)stop{
    toStop = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
