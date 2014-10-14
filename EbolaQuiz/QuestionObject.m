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
        NSString *answerString = [[xmlElement attributes] objectForKey:@"answers"];
        if ([answerString isEqualToString:@"fillin"]) {
            self.type = @"fillin";
            self.answers = [NSArray array];
        }else
        {
            self.type = @"optional";
            self.answers = [answerString componentsSeparatedByString:@","];
        }
        
        NSArray *elements  = [xmlElement childrenWithTagName:@"option"];
        self.options = [NSMutableArray array];
        for (TFHppleElement *optionEle in elements) {
            [self.options addObject:[[OptionObject alloc] initWithTFHppleElement:optionEle]];
        }
    }
    return self;
}
-(BOOL)isRight:(NSString *)answer{
    for (NSString *rightAnswer in self.answers) {
        if ([rightAnswer isEqualToString:answer]) {
            return YES;
        }
    }
    return NO;
}
@end
