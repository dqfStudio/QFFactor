//
//  QFCreateFile.m
//  QFFactor
//
//  Created by dqf on 2017/9/3.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "QFCreateFile.h"
#import "QFFileHelper.h"
#import "NSStringUtil.h"

#define KEYHFILE @"/Users/issuser/Documents/GitHub/QFFactor/QFFactor/KEY.h"

#define HTFILE @"/Users/issuser/Documents/GitHub/QFFactor/QFFactor/Source/HTemplate.h"
#define HMFILE @"/Users/issuser/Documents/GitHub/QFFactor/QFFactor/Source/MTemplate.h"

#define KFloder @"/Users/issuser/Documents/GitHub/QFFactor/Factor/"

#define KInit @"- (id)init {\n\
    self=[super init];\n\
    if (self) {\n\
        #name#\n\
    }\n\
    return self;\n\
}"

@implementation QFCreateFile

+ (void)createFile:(NSString *)name {
    [self writeHFile:name];
    [self writeMFile:name];
}

+ (void)writeHProperty:(NSString *)path {
    __block NSInteger count = 0;
    __block NSString *htemplate = @"KDProperty(#name#)";
    [QFFileHelper file:KEYHFILE block:^(NSString *lineStr) {
        NSString *lineString = lineStr.replace(@" ", @"").replace(@"\n", @"");
        if (lineString.length > 0) {
            count++;
            [QFFileHelper file:path append:htemplate.replace(@"#name#", lineString)];
            if (count%3==0) {
                [QFFileHelper file:path append:@"\n" wrap:NO];
            }
        }
    }];
}

+ (void)writeMProperty:(NSString *)path {
    __block NSString *mtemplate = @"KDGetter(#name1#, #name2#)";
    [QFFileHelper file:KEYHFILE block:^(NSString *lineStr) {
        NSString *lineString = lineStr.replace(@" ", @"").replace(@"\n", @"");
        if (lineString.length > 0) {
            [QFFileHelper file:path append:mtemplate.replace(@"#name1#", lineString).replace(@"#name2#", @"_".append(lineString))];
        }
    }];
    
    
    __block NSInteger count = 0;
    __block NSString *Itemplate = @"self.name.weight = 0.f;";
    __block NSString *str = KInit;
    [QFFileHelper file:path append:@"\n" wrap:NO];
    [QFFileHelper file:KEYHFILE block:^(NSString *lineStr) {
        NSString *lineString = lineStr.replace(@" ", @"").replace(@"\n", @"");
        if (lineString.length > 0) {
            count++;
            if (count%3==0) {
                str = str.replace(@"#name#", Itemplate.replace(@"name", lineString).append(@"\n\n").append(@"\t\t#name#"));
            }else {
                str = str.replace(@"#name#", Itemplate.replace(@"name", lineString).append(@"\n").append(@"\t\t#name#"));
            }
            
        }
    }];
    str = str.replace(@"#name#", @"/*QFFactor*/".replace(@"QFFactor", [path.lastPathComponent stringByDeletingPathExtension]));
    [QFFileHelper file:path append:str];
    [QFFileHelper file:path append:@"\n" wrap:NO];
}

+ (void)writeHFile:(NSString *)name {
    NSString *str = [[NSString alloc] initWithContentsOfFile:HTFILE encoding:NSUTF8StringEncoding error:nil];
    NSString *path = KFloder.append(name).append(@".h");
    [QFFileHelper file:path append:str.replace(@"#name#", name)];
    [self writeHProperty:path];
    [QFFileHelper file:path append:@"\n" wrap:NO];
    [QFFileHelper file:path append:@"@end"];
}

+ (void)writeMFile:(NSString *)name {
    NSString *str = [[NSString alloc] initWithContentsOfFile:HMFILE encoding:NSUTF8StringEncoding error:nil];
    NSString *path = KFloder.append(name).append(@".m");
    [QFFileHelper file:path append:str.replace(@"#name#", name)];
    [self writeMProperty:path];
    [QFFileHelper file:path append:@"@end"];
}

@end

