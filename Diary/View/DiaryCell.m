//
//  DiaryCell.m
//  Diary
//
//  Created by 思 彭 on 16/8/3.
//  Copyright © 2016年 思 彭. All rights reserved.
//

#import "DiaryCell.h"
#import "DiaryModel.h"

@interface DiaryCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *colorLabel;

@end

@implementation DiaryCell

- (void)awakeFromNib {

    self.colorLabel.layer.masksToBounds = YES;
    self.colorLabel.layer.cornerRadius = 5.0;
}

- (void)setModel:(DiaryModel *)model{
    
    _model = model;
    self.timeLabel.text = model.timer;
    self.titleLabel.text = model.title;
    self.colorLabel.backgroundColor = model.bgcolor;
    
}

@end
