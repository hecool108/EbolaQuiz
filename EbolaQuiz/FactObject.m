//
//  FactObject.m
//  EbolaQuiz
//
//  Created by 王贺 on 14/10/20.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "FactObject.h"

@implementation FactObject
- (id)initWithTFHppleElement:(TFHppleElement *)xmlElement{
    self = [super init];
    if (self) {
        self.theId = [[xmlElement attributes] objectForKey:@"id"];
        self.subject = [[xmlElement attributes] objectForKey:@"subject"];
        self.imageName = [[xmlElement attributes] objectForKey:@"image"];
    }
    return self;
}
@end
