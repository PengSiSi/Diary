//
//  AddViewController.m
//  Diary
//
//  Created by 思 彭 on 16/8/2.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "AddViewController.h"
#import "DiaryModel.h"
#import "DiaryManage.h"
#import "textViewPlaceHolder.h"

@interface AddViewController ()

@property (nonatomic,strong) NSArray *colorsArray;
@property (nonatomic,strong) NSArray *titlesArray;
@property (nonatomic,strong) UITextField *titleTF;
@property (nonatomic,strong) textViewPlaceHolder *textTF;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"编辑今日心情";
    self.view.backgroundColor = [UIColor iOS7greenColor];
    [self setNav];
    [self initData];
}


- (void)initData{
    
    self.colorsArray = @[[UIColor iOS7redColor],[UIColor iOS7orangeColor],[UIColor iOS7yellowColor],[UIColor iOS7greenColor],[UIColor iOS7lightBlueColor]];
    for (NSInteger i = 0; i < 5; i++) {
        
        // 选择心情颜色按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat x = (k_ScreenWidth - 5 * 59) / 2;
        button.frame = CGRectMake(x + 60 * i, 80, 70, 44);
        button.backgroundColor = self.colorsArray[i];
        [button addTarget:self action:@selector(selectColor:) forControlEvents:UIControlEventTouchUpInside];
        button.layer.borderColor = [UIColor blackColor].CGColor;
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5;
        button.tag = i + 1;
        [self.view addSubview:button];
    }
    self.titlesArray = @[@"标题: ",@"正文: "];
    for (NSInteger i = 0; i < 2; i++) {
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 44*i+140, 50, 44)];
        titleLabel.text = self.titlesArray[i];
        titleLabel.textColor = [UIColor blackColor];
        [self.view addSubview:titleLabel];
    }
    self.titleTF=[[UITextField alloc]initWithFrame:CGRectMake(70, 130, k_ScreenWidth - 100, 40)];
    self.titleTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.titleTF.placeholder = @"一句话描述自己的心情哟!!!";
    self.titleTF.layer.cornerRadius=5;
    self.titleTF.layer.borderColor=[UIColor blackColor].CGColor;
    self.titleTF.layer.borderWidth=1;
    [self.view addSubview:self.titleTF];
    self.textTF=[[textViewPlaceHolder alloc]initWithFrame:CGRectMake(70, 190, k_ScreenWidth - 100, 250)];
    self.textTF.placeHolderColor = [UIColor colorWithRed:139/255.0 green:134/255.0 blue:132/255.0 alpha:1];
    self.textTF.placeHolderText = @"详细记录今天的事情哟!!!";
    self.textTF.font = [UIFont systemFontOfSize:17];
    self.textTF.returnKeyType = UIReturnKeyDefault;//返回键的类型
    self.textTF.keyboardType = UIKeyboardTypeDefault;//键盘类型
    self.textTF.scrollEnabled = YES;//是否可以拖动
//    self.textTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textTF.layer.borderColor=[UIColor blackColor].CGColor;
    self.textTF.layer.borderWidth=1;
    self.textTF.backgroundColor = [UIColor iOS7greenColor];
    self.textTF.layer.cornerRadius=5;
    [self.view addSubview:self.textTF];
}

- (void)setNav{
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveItemClick:)];
    self.navigationItem.rightBarButtonItem = saveItem;
    
    UIBarButtonItem *backitem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(BackMainvc:)];
    self.navigationItem.leftBarButtonItem = backitem;
    
}

// 返回
- (void)BackMainvc: (UIBarButtonItem *)barItem{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveItemClick: (UIBarButtonItem *)barItem{

    NSLog(@"保存日记");
    
    if (self.titleTF.text.length == 0 || self.textTF.text.length == 0) {
        
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请编辑内容再保存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
        return;
    }
    DiaryModel *model = [[DiaryModel alloc]init];
    model.title = self.titleTF.text;
    model.text = self.textTF.text;
    model.bgcolor = self.view.backgroundColor;
    // 保存日期
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *time = [formatter stringFromDate:date];
    model.timer = time;
    
    // 保存到数据库
    DiaryManage *manage = [[DiaryManage alloc]init];
    [manage saveDataWithModel:model];
    self.titleTF.text = nil;
    self.textTF.text = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)selectColor: (UIButton *)colorButton{
    
    NSLog(@"选择颜色");
    self.view.backgroundColor = colorButton.backgroundColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    // 点击屏幕结束编辑操作,收起键盘
    [self.view endEditing:YES];
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"确定"]) {
        NSLog(@"点击确定");
    }
    else{
        
        NSLog(@"点击取消");
    }
}

@end
