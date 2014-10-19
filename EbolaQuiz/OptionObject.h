//
//  OptionObject.h
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-11.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
@interface OptionObject : NSObject
@property (nonatomic) NSString * id;
@property (nonatomic) NSString * statement;
@property (nonatomic) NSString * imageName;
- (id)initWithTFHppleElement:(TFHppleElement *)xmlElement;

@end
