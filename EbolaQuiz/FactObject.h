//
//  FactObject.h
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/20.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
@interface FactObject : NSObject
@property(nonatomic)NSString *theId;
@property(nonatomic)NSString *subject;
@property(nonatomic)NSString *imageName;
- (id)initWithTFHppleElement:(TFHppleElement *)xmlElement;
@end
