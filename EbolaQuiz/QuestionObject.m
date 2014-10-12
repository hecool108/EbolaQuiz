//
//  QuestionObject.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-11.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "QuestionObject.h"
#import "OptionObject.h"

@implementation QuestionObject
- (id)initWithTFHppleElement:(TFHppleElement *)xmlElement
{
    self = [super init];
    if (self) {
        self.id = [[xmlElement attributes] objectForKey:@"id"];
        self.subject = [[xmlElement attributes] objectForKey:@"subject"];
        self.desc = [[xmlElement attributes] objectForKey:@"desc"];
        self.answers = [[xmlElement attributes] objectForKey:@"answers"];
        NSArray *elements  = [xmlElement childrenWithTagName:@"option"];
        self.options = [NSMutableArray array];
        for (TFHppleElement *optionEle in elements) {
            [self.options addObject:[[OptionObject alloc] initWithTFHppleElement:optionEle]];
        }
    }
    return self;
}
@end
