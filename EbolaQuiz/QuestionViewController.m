//
//  QuestionViewController.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-12.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "QuestionViewController.h"
#import "QuestionObject.h"
#import "OptionItem.h"
#import "OptionObject.h"
#import "TFHpple.h"
@interface QuestionViewController (){
    NSMutableArray *questionsItems;
    NSMutableArray *questions;
    QuestionObject *currentQuestion;
    int questionIndex;
}

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    questionIndex = 0;
    [self initQuestions];
    [self initView];
}
-(void)initView{
    questionsItems = [NSMutableArray array];
    for (int i = 0; i < 4; i++) {
        OptionItem *optionItem = [[OptionItem alloc] initWithFrame:CGRectMake(10, 100+i*60, 300, 50)];
        optionItem.backgroundColor = [UIColor grayColor];
        [self.view addSubview:optionItem];
        [questionsItems addObject:optionItem];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [optionItem addGestureRecognizer:tap];
    }
    currentQuestion = [questions objectAtIndex:0];
    [self showQuestion];
}
-(void)onTap:(UITapGestureRecognizer *)sender{
    OptionItem *item = (OptionItem *)sender.view;
    if ([item.optionObj.id isEqualToString:currentQuestion.answers]) {
        NSLog(@"YES!!");
        [self nextQuestion];
    }else
    {
        NSLog(@"NO!!!!");
    }
    
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

-(void)nextQuestion{
    if (questionIndex + 1 < questions.count) {
        questionIndex++;
    }
    currentQuestion = questions[questionIndex];
    [self showQuestion];
}
-(void)prevQuestion{
    if (questionIndex - 1 >= 0) {
        questionIndex--;
    }
    currentQuestion = questions[questionIndex];
    [self showQuestion];
}
-(void)showQuestion{
    self.questionLabel.text = currentQuestion.subject;
    for (int i = 0; i < 4; i++) {
        OptionItem *item = [questionsItems objectAtIndex:i];
        if (i < currentQuestion.options.count) {
            OptionObject *option = currentQuestion.options[i];
            [item updateData:option];
        }else
        {
            [item updateData:nil];
        }
        
    }
}
@end
