//
//  DiaryModel.h
//  Diary
//
//  Created by 思 彭 on 16/8/3.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiaryModel : NSObject

@property(nonatomic,strong) NSString *title; // 标题
@property(nonatomic,strong) NSString *text; // 内容
@property(nonatomic,strong) UIColor *bgcolor; // 背景颜色
@property(nonatomic,strong) NSString *timer; //日期

@end
