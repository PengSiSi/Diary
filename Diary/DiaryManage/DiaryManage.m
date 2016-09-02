//
//  DiaryManage.m
//  Diary
//
//  Created by 思 彭 on 16/8/3.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "DiaryManage.h"
#import "DiaryModel.h"
#import "FMDB.h"

@interface DiaryManage ()

@property (nonatomic,strong) FMDatabase *database;

@end
@implementation DiaryManage

// 增加
- (void)saveDataWithModel: (DiaryModel *)model
{
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/note.db"];
    self.database=[FMDatabase databaseWithPath:path];
    if (![_database open]) {
        [_database close];
    }
    if (![_database tableExists:@"NotaTable"]) {
        [_database executeUpdate:@"CREATE TABLE NotaTable (title TEXT,text TEXT,time TEXT,color TEXT)"];
    }
    else{
        NSLog(@"数据表已存在");
    }
    NSString *color=[NSString stringWithFormat:@"%@",model.bgcolor];
    [_database executeUpdate:@"INSERT INTO NotaTable VALUES(?,?,?,?)",model.title,model.text,model.timer,color];
    NSLog(@"添加日记成功");
    [_database close];
}

// 查找
- (NSArray *)getData
{
    NSLog(@"开始查找数据...");
    NSMutableArray *array=[NSMutableArray array];
    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/note.db"];
    _database=[FMDatabase databaseWithPath:path];
    if (![_database open]) {
        [_database close];
    }
    if ([_database tableExists:@"NotaTable"]) {
        FMResultSet *resultset=[_database executeQuery:@"SELECT * FROM NotaTable"];
        while ([resultset next]) {
            NSString *title=[resultset stringForColumnIndex:0];
            NSString *text=[resultset stringForColumnIndex:1];
            NSString *time=[resultset stringForColumnIndex:2];
            NSString *color=[resultset stringForColumnIndex:3];
            DiaryModel *model=[[DiaryModel alloc]init];
            model.title=title;
            model.text=text;
            model.timer=time;
            NSArray *colorarr=[color componentsSeparatedByString:@" "];
            float a=[colorarr[1]floatValue];
            float b=[colorarr[2]floatValue];
            float c=[colorarr[3]floatValue];
            float d=[colorarr[4]floatValue];
            model.bgcolor=[UIColor colorWithRed:a green:b blue:c alpha:d];
            
            [array addObject:model];
        }
    }
    NSLog(@"已查到数据...");
       return array;
}

// 删除
- (void)deleteData: (DiaryModel *)model{

    NSString *path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/note.db"];
    _database=[FMDatabase databaseWithPath:path];
    
    // 判断数据库有没有打开
    if (![_database open]) {
        NSLog(@"请先执行打开数据库");
        return;
    }
    NSString * sqlString = [NSString stringWithFormat:@"delete from NotaTable where title = '%@'",model.title];
    BOOL deleteSuccess = [_database executeUpdate:sqlString];
    if (deleteSuccess) {
        NSLog(@"删除成功");
    }
    else{
        NSLog(@"删除失败");
    }
}

@end
