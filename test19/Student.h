//
//  Student.h
//  test19
//
//  Created by ShenDeju on 15/12/15.
//  Copyright © 2015年 ShenDJ.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@interface Student : NSObject
@property(assign,nonatomic) NSUInteger number;
@property(strong,nonatomic) NSString *name;
@property(assign,nonatomic) NSUInteger age;
@property(strong,nonatomic) NSString *gender;
@property(assign,nonatomic) CGFloat score;

@end
