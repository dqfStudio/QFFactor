//
//  NSStringUtil.m
//  TestProj
//
//  Created by dqf on 2017/8/10.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "NSStringUtil.h"

@implementation NSString (Util)

+ (NSString *(^)(id))append {
    return ^NSString *(id obj) {
        return [NSString stringWithFormat:@"%@",obj];
    };
}

- (NSString *(^)(id))append {
    return ^NSString *(id obj) {
        return [NSString stringWithFormat:@"%@%@", self,obj];
    };
}

+ (NSString *(^)(NSString *, NSUInteger))appendCount {
    return ^NSString *(NSString *org, NSUInteger count) {
        NSMutableString *mutableStr = [[NSMutableString alloc] init];
        for (int i=0; i<count; i++) {
            [mutableStr appendString:org];
        }
        return mutableStr;
    };
}

- (NSString *(^)(NSString *, NSUInteger))appendCount {
    return ^NSString *(NSString *org, NSUInteger count) {
        NSMutableString *mutableStr = [[NSMutableString alloc] initWithString:self];
        for (int i=0; i<count; i++) {
            [mutableStr appendString:org];
        }
        return mutableStr;
    };
}

- (NSString *(^)(NSString *, NSString *))replace {
    return ^NSString *(NSString *org1, NSString *org2) {
        return [self stringByReplacingOccurrencesOfString:org1 withString:org2];
    };
}

//空格
+ (NSString *(^)(NSUInteger))space {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@" ", count);
    };
}

- (NSString *(^)(NSUInteger))space {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@" ", count);
    };
}

//tab
+ (NSString *(^)(NSUInteger))tab {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@"\t", count);
    };
}

- (NSString *(^)(NSUInteger))tab {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@"\t", count);
    };
}

//换行
+ (NSString *(^)(NSUInteger))wrap {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@"\n", count);
    };
}

- (NSString *(^)(NSUInteger))wrap {
    return ^NSString *(NSUInteger count) {
        return self.appendCount(@"\n", count);
    };
}

- (NSString *(^)(NSString *))subStringToStart {
    return ^NSString *(NSString *aString) {
        NSRange range = [self rangeOfString:aString];
        return [self substringToIndex:range.location];
    };
}

- (NSString *(^)(NSString *))subStringToEnd {
    return ^NSString *(NSString *aString) {
        NSRange range = [self rangeOfString:aString];
        return [self substringToIndex:range.location+range.length];
    };
}

- (NSString *(^)(NSString *))subStringFromStart {
    return ^NSString *(NSString *aString) {
        NSRange range = [self rangeOfString:aString];
        return [self substringFromIndex:range.location];
    };
}

- (NSString *(^)(NSString *))subStringFromEnd {
    return ^NSString *(NSString *aString) {
        NSRange range = [self rangeOfString:aString];
        return [self substringFromIndex:range.location+range.length];
    };
}

- (NSArray<NSString *> *(^)(NSString *))componentsByString {
    return ^NSArray<NSString *> *(NSString *separator) {
        return [self componentsSeparatedByString:separator];
    };
}

- (NSArray<NSString *> *(^)(NSString *))componentsBySetString {
    return ^NSArray<NSString *> *(NSString *separator) {
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:separator];
        NSArray *arr = [self componentsSeparatedByCharactersInSet:characterSet];
        NSMutableArray *mutablerArr = [NSMutableArray new];
        //过滤掉为空的字符串
        for (int i=0; i<arr.count; i++) {
            NSString *str = arr[i];
            if (str.length > 0) {
                [mutablerArr addObject:str];
            }
        }
        return mutablerArr;
    };
}

- (NSArray<NSString *> *(^)(NSString *, NSString *))componentsByStringBySetString {
    return ^NSArray<NSString *> *(NSString *separator, NSString *setSeparator) {
        NSMutableArray *mutablerArr = [NSMutableArray new];
        NSArray *arr = self.componentsByString(separator);
        for (int i=0; i<arr.count; i++) {
            NSString *str = arr[i];
            NSArray *tmpArr = str.componentsBySetString(setSeparator);
            [mutablerArr addObjectsFromArray:tmpArr];
        }
        return mutablerArr;
    };
}

- (BOOL(^)(NSString *))containsString {
    return ^BOOL(NSString *org) {
        return [self containsString:org];
    };
}

- (BOOL(^)(NSArray<NSString *> *))containsStrArr {
    return ^BOOL(NSArray *arr) {
        if (arr.count <= 0) return NO;
        BOOL contain = YES;
        for (NSString *str in arr) {
            if (![self containsString:str]) {
                contain = NO;
            }
        }
        return contain;
    };
}

@end
