//
//  ViewController.m
//  test19
//
//  Created by ShenDeju on 15/12/15.
//  Copyright © 2015年 ShenDJ.com. All rights reserved.
//

#import "ViewController.h"
#import "SDBManage.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *stu1 = [Student new];
    stu1.number = 1;
    stu1.name = @"efhu";
    stu1.age = 21;
    stu1.gender = @"男";
    stu1.score = 78;
    
    Student *stu2 = [Student new];
    stu2.number = 2;
    stu2.name = @"efhu";
    stu2.age = 22;
    stu2.gender = @"男";
    stu2.score = 72;
    
    Student *stu3 = [Student new];
    stu3.number = 3;
    stu3.name = @"efhu";
    stu3.age = 23;
    stu3.gender = @"男";
    stu3.score = 73;
    
    
    
    
    SDBManage *manager = [SDBManage new];
    
    [manager openDataBase];
    //[manager createTable];
    
//    [manager insertDataFromStudent:stu1];
//    [manager insertDataFromStudent:stu2];
//    [manager insertDataFromStudent:stu3];
    
   // [manager deleteDataWithNumber:3];
    
   // [manager updateDataForName:@"fjeoipah" withNumber:2];
    
    NSArray *array = [manager seletedAllData];
    NSLog(@"%@",array[0]);
    
    
    [manager closeDataBase];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
