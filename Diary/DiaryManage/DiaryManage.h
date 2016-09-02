//
//  DiaryManage.h
//  Diary
//
//  Created by 思 彭 on 16/8/3.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DiaryModel;

@interface DiaryManage : NSObject

// 保存日记
- (void)saveDataWithModel: (DiaryModel *)model;

// 取得日记
- (NSArray *)getData;

// 删除日记
- (void)deleteData: (DiaryModel *)model;


@end
