//
//  ViewController.m
//  Diary
//
//  Created by 思 彭 on 16/8/2.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "ViewController.h"
#import "MainViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor iOS7greenColor];
    UILabel *Label = [[UILabel alloc] init];
    [self.view addSubview:Label];
    [Label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.view);
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(500);
    }];
    Label.text = @"欢迎来到思思的日记\n记录自己每天的心情!!!\n\n\n点击进入哟!!!";
    Label.numberOfLines = 0;
    Label.textColor = [UIColor blackColor];
    Label.font = [UIFont systemFontOfSize:25];
    Label.textAlignment = NSTextAlignmentCenter;

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    MainViewController *mainVc = [[MainViewController alloc]init];
    [self.navigationController pushViewController:mainVc animated:YES];
    
}
@end
