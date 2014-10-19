//
//  VirusGenerator.m
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/19.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "FloatingVirus.h"
#import "VirusGenerator.h"
@interface VirusGenerator(){
    NSMutableArray *viruses;
}
@end
@implementation VirusGenerator
-(void)initVirusNumbers:(int)numbers{
    if (viruses == nil) {
        viruses = [NSMutableArray array];
    }
    int randomType;
    for (int i = 0;i < numbers;i++) {
        randomType = arc4random_uniform(5)+1;
        FloatingVirus *virus = [[FloatingVirus alloc] initWithVirusType:randomType rect:self.frame];
        [viruses addObject:virus];
        [self addSubview:virus];
        [virus start];
    }
}
-(void)stopAndRemoveAll{
    for (FloatingVirus *virus in viruses) {
        [virus stop];
        [virus removeFromSuperview];
    }
}
@end
