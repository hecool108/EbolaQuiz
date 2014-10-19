//
//  FloatingVirus.h
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/19.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FloatingVirus : UIImageView
- (id)initWithVirusType:(int)type rect:(CGRect)rect;
-(void)start;
-(void)stop;
@end
