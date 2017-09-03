//
//  NSFactor.h
//  TestProject
//
//  Created by dqf on 2017/9/3.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KDProperty(name) @property (nonatomic, strong) NSFactor *name;
#define KDGetter(name1, name2) - (NSFactor *)name1 {\
    if (!name2) {\
        name2 = [NSFactor new];\
    }\
    return name2;\
}


//因子
@interface NSFactor : NSObject
//比率
@property (nonatomic) float ratio;
//权重
@property (nonatomic) float weight;
@end
