//
//  FactsViewController.h
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/20.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FactsViewController : UIViewController
- (IBAction)shareFact:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@end
