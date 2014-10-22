//
//  SingleFactViewController.h
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/22.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FactObject.h"
@interface SingleFactViewController : UIViewController
@property(nonatomic)FactObject *factData;
@property(nonatomic)int pageIndex;
@end
