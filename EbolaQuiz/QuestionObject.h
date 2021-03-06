//
//  QuestionObject.h
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-11.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
@interface QuestionObject : NSObject


@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSMutableArray *options;
@property (nonatomic, retain) NSArray *answers;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *imageName;

- (id)initWithTFHppleElement:(TFHppleElement *)xmlElement;
-(BOOL)isRight:(NSString *)answer;
@end
