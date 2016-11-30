//
//  SubFindFactory.h
//  喜马
//
//  Created by 鲁静亚 on 2016/11/30.
//  Copyright © 2016年 鲁静亚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FindBasicViewController.h"

@interface SubFindFactory : NSObject

+ (FindBasicViewController *)subFindControllerWithIdentifier:(NSString *)identifier;
@end
