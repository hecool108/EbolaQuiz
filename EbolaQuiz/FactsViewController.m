//
//  FactsViewController.m
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/20.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "FactsViewController.h"

@interface FactsViewController (){
    NSMutableArray *facts;
}
@property (strong, nonatomic) IBOutlet UILabel *factLabel;

@end

@implementation FactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    questions = [NSMutableArray array];
//    NSError *error;
//    NSString *str=[[NSBundle mainBundle] pathForResource:@"questions" ofType:@"xml"];
//    NSData *data = [NSData dataWithContentsOfFile:str options:NSDataReadingMapped error:&error];
//    TFHpple * doc       = [[TFHpple alloc] initWithHTMLData:data];
//    NSArray *elements  = [doc searchWithXPathQuery:@"//question"];
//    for (int i = 0; i < elements.count; i++) {
//        TFHppleElement *ele = elements[i];
//        [questions addObject:[[QuestionObject alloc] initWithTFHppleElement:ele]];
//    }
    
}
@end
