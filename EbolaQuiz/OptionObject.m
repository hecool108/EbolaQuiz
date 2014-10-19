//
//  OptionObject.m
//  EbolaQuiz
//
//  Created by 王贺 on 14-10-11.
//  Copyright (c) 2014年 us.hector. All rights reserved.
//

#import "OptionObject.h"

@implementation OptionObject
- (id)initWithTFHppleElement:(TFHppleElement *)xmlElement{
    self = [super init];
    if (self) {
        self.id = [[xmlElement attributes] objectForKey:@"id"];
        self.statement = [[xmlElement attributes] objectForKey:@"statement"];
        self.imageName = [[xmlElement attributes] objectForKey:@"image"];
    }
    return self;
}
@end
