//
//  UIGenerator.h
//  iyuesairunning
//
//  Created by 王贺 on 14-10-9.
//  Copyright (c) 2014年 wisdom-china. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIGenerator : NSObject
+(UILabel *)createSystemLabel:(CGRect)theRect size:(float)size color:(UIColor *)color;
+(UILabel *)createSystemLabel:(CGRect)theRect size:(float)size color:(UIColor *)color align:(NSTextAlignment)align;
+(UILabel *)labelWithRect:(CGRect)rect andColor:(UIColor *)color andAlign:(NSTextAlignment)align;
@end
