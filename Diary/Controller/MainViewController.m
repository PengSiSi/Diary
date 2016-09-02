//
//  MainViewController.m
//  Diary
//
//  Created by 思 彭 on 16/8/2.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "MainViewController.h"
#import "AddViewController.h"
#import "DiaryCell.h"
#import "DiaryManage.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "DiaryModel.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) DiaryManage *manage;

@end

@implementation MainViewController

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    
    // 从数据库取得model数据
    _manage = [[DiaryManage alloc]init];
    self.dataArray = [[_manage getData] mutableCopy];
    if (self.dataArray.count == 0) {
        NSLog(@"添加日记");
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"点击右上角+赶紧添加今天的心情吧!!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertView show];

    }
    [self.myTableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"日记";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNav];
    [self createUI];
}

// 创建表视图
- (void)createUI{
   
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.edges.mas_equalTo(self.view);
    }];

    self.myTableView.tableFooterView = [[UIView alloc]init];
    // 注册cell
    [self.myTableView registerNib:[UINib nibWithNibName:@"DiaryCell" bundle:nil] forCellReuseIdentifier:@"DiaryCell"];
    
}

- (void)setNav{
    
    UIBarButtonItem *addItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItemClick:)];
    
    self.navigationItem.rightBarButtonItem = addItem;
}


- (void)addItemClick: (UIBarButtonItem *)barItem{
    
    NSLog(@"添加今日日记");
    AddViewController *addVc = [[AddViewController alloc]init];
    [self.navigationController pushViewController:addVc animated:YES];
    
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiaryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiaryCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:@"DiaryCell" cacheByIndexPath:indexPath configuration:^(DiaryCell *cell) {
        cell.model = self.dataArray[indexPath.row];
    }];
}

// 侧滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}


//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setEditing:NO animated:YES];
    NSLog(@"点击删除按钮");
    DiaryModel *diaryModel = self.dataArray[indexPath.row];
    // 删除记录
    [_manage deleteData:diaryModel];
    [self.dataArray removeObjectAtIndex:indexPath.row];
//    self.dataArray = [[_manage getData]mutableCopy];
    [self.myTableView reloadData];
}

// 懒加载
- (UITableView *)myTableView{
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
