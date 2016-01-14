//
//  SDBManage.h
//  test19
//
//  Created by ShenDeju on 15/12/15.
//  Copyright © 2015年 ShenDJ.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Student.h"
@interface SDBManage : NSObject <NSCopying,NSMutableCopying>
+(instancetype) shareManager;

-(void) openDataBase;
-(void) closeDataBase;
-(void) createTable;
-(void) insertDataFromStudent:(Student*) student;
-(void) deleteDataWithNumber:(NSUInteger) number;
-(void) updateDataForName:(NSString*) name withNumber:(NSUInteger) number;
-(NSArray *) seletedAllData;
@end
