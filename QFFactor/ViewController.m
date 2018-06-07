//
//  ViewController.m
//  QFFactor
//
//  Created by dqf on 2017/9/3.
//  Copyright © 2017年 dqfStudio. All rights reserved.
//

#import "ViewController.h"
#import "QFCreateFile.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [QFCreateFile createFile:@"QFCity"];
    

}

- (void)lisiAction {
    
}

@end
