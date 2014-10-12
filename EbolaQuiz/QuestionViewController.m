//
//  QuestionViewController.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-12.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionObject.h"
#import "OptionObject.h"
#import "TFHpple.h"
@interface QuestionViewController (){
    NSMutableArray *questions;
}

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initQuestions];
}
-(void)initQuestions{
    questions = [NSMutableArray array];
    NSError *error;
    NSString *str=[[NSBundle mainBundle] pathForResource:@"questions" ofType:@"xml"];
    NSData *data = [NSData dataWithContentsOfFile:str options:NSDataReadingMapped error:&error];
    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
    NSArray *elements  = [doc searchWithXPathQuery:@"//question"];
    for (int i = 0; i < elements.count; i++) {
        TFHppleElement *ele = elements[i];
        [questions addObject:[[QuestionObject alloc] initWithTFHppleElement:ele]];
    }
}
@end
