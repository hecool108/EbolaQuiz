//
//  SingleFactViewController.m
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/22.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "SingleFactViewController.h"

@interface SingleFactViewController (){
    UIScrollView *scrollView;
}

@property (strong, nonatomic) IBOutlet UILabel *factLabel;
@end

@implementation SingleFactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.factData != nil) {
        scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:scrollView];
        
        self.factLabel.text = self.factData.subject;
        self.factLabel.frame = CGRectMake(self.factLabel.frame.origin.x, self.factLabel.frame.origin.y, 250, 0);
        self.factLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.factLabel.numberOfLines = 0;
        [self.factLabel sizeToFit];
        [scrollView addSubview:_factLabel];
        
        if (![_factData.imageName isEqualToString:@""]) {
            NSLog(@"%@",[UIImage imageNamed:_factData.imageName]);
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_factData.imageName]];
            imageView.center = CGPointMake(self.view.center.x, imageView.image.size.height/2 + 100);
            [scrollView addSubview:imageView];
            CGRect labelRect = self.factLabel.frame;
            labelRect.origin.y = imageView.frame.size.height + imageView.frame.origin.y + 10;
            self.factLabel.frame = labelRect;
        }
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.factLabel.frame.origin.y+self.factLabel.frame.size.height);
        
        
    }
    self.view.backgroundColor = [UIColor clearColor];
}
@end
