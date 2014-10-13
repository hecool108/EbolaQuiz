//
//  OptionItem.h
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-13.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OptionObject.h"
@interface OptionItem : UIView
@property(nonatomic)OptionObject *optionObj;
-(void)updateData:(OptionObject *)option;
@end
