//
//  SubFindFactory.m
//  喜马
//
//  Created by 鲁静亚 on 2016/11/30.
//  Copyright © 2016年 鲁静亚. All rights reserved.
//

#import "SubFindFactory.h"
#import "FirstViewController.h"
#import "SecViewController.h"

@implementation SubFindFactory

+ (FindBasicViewController *)subFindControllerWithIdentifier:(NSString *)identifier
{
    FindBasicViewController* controller = nil;
    if ([identifier isEqualToString:@"a"]) {
        controller = [[FirstViewController alloc]init];
    } else if ([identifier isEqualToString:@"b"])
    {
        controller = [[SecViewController alloc]init];
    }
    return controller;
}
@end
