//
//  SDBManage.m
//  test19
//
//  Created by ShenDeju on 15/12/15.
//  Copyright © 2015年 ShenDJ.com. All rights reserved.
//

#import "SDBManage.h"
static SDBManage *manager =nil;
static sqlite3 *db = nil;

@implementation SDBManage
+(instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self new];
    });
    return manager;
}

#pragma mark ---完善单例----
+(instancetype) allocWithZone:(struct _NSZone *)zone{
    
    @synchronized(manager) {
        if (!manager) {
            manager = [super allocWithZone:zone];
        }
    }
    return manager;
}
-(instancetype)init{
    @synchronized(self) {
        self = [super init];
        return self;
    }
}
-(id)copyWithZone:(NSZone *)zone
{
    return self;
}
-(id)copy{
    return self;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}

-(id)mutableCopy{
    return self;
}


#pragma mark-----数据库操作

-(void)openDataBase{
    if (db) {
        return;
    }
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = [path stringByAppendingPathComponent:@"StudentInfo.sqlite"];
    int result = sqlite3_open([path UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"打开成功");
    }
    else{
        NSLog(@"打开失败,错误代码是%d",result);
    }
}

-(void) closeDataBase
{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭成功");
    }
    else
    {
        NSLog(@"关闭失败,.错误代码是%d",result);
    }
}

-(void) createTable{
    NSString *sqlWord =  @"CREATE TABLE IF NOT EXISTS 's_student' ('number' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL UNIQUE, 'name' TEXT NOT NULL, 'age' INTEGER DEFAULT 18, 'gender' TEXT DEFAULT 男, 'score' REAL NOT NULL)";
    int result = sqlite3_exec(db, sqlWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"创建表成功");
    }else{
        NSLog(@"创建表失败,错误代码是%d",result);
    }
    
}


-(void)insertDataFromStudent:(Student *)student{
    
    NSString *sqlWord = [NSString stringWithFormat:@"INSERT INTO 's_student' VALUES (%lu,'%@',%lu,'%@',%lf)",student.number,student.name,student.age,student.gender,student.score];
    int result = sqlite3_exec(db, sqlWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"插入成功");
    }else
    {
        NSLog(@"插入失败,错误代码是%d",result);
    }
}


-(void)deleteDataWithNumber:(NSUInteger)number{
    
    NSString *sqlWord = [NSString stringWithFormat:@"DELETE FROM s_student where number = %lu",number];
    int result  = sqlite3_exec(db, sqlWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败,错误代码是%d",result);
    }
}

-(void)updateDataForName:(NSString *)name withNumber:(NSUInteger)number
{
    NSString *sqlWord = [NSString stringWithFormat:@"UPDATE s_student SET name = '%@' where number = %lu",name,number];
    int result = sqlite3_exec(db, sqlWord.UTF8String, NULL,NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"更改成功");
    }
    else{
        NSLog(@"更改失败,错误代码是%d",result);
    }
}

-(NSArray *)seletedAllData{
    NSMutableArray *array = nil;
    sqlite3_stmt *stmt = nil;
    NSString *sqlWord = @"SELECT * FROM 's_student'";
    int result = sqlite3_prepare(db, sqlWord.UTF8String, -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        array = [[NSMutableArray alloc] initWithCapacity:10];
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            Student *student = [Student new];
            student.number = sqlite3_column_int(stmt, 0);
            student.name = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 1)];
            student.age = sqlite3_column_int(stmt, 2);
            student.gender = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 3)];
            student.score = sqlite3_column_double(stmt, 4);
            
            [array addObject:student];
        }
        
        
    }
    sqlite3_finalize(stmt);
    return array;
}





@end
