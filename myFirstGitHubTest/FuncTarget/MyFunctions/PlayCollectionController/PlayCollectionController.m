//
//  PlayCollectionController.m
//  FuncTarget
//
//  Created by 程昂 on 2017/3/14.
//  Copyright © 2017年 程昂. All rights reserved.
//

#import "PlayCollectionController.h"
#import "PlayInfoCell.h"

@interface PlayCollectionController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView *_titleView;
    UICollectionView *_collectionView;
}

@end

@implementation PlayCollectionController

static NSString * const cellIdentify = @"collectionCellString";

- (void)createTitleView{
    _titleView = [UIView new];
    _titleView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_titleView];
    
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@0);
        make.height.mas_equalTo(@64);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
    }];
    [_titleView layoutIfNeeded];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor orangeColor];
    titleLabel.text = @"瀑布流测试";
    [_titleView addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView).mas_equalTo(@0);
        make.left.equalTo(_titleView).mas_equalTo(@0);
        make.height.equalTo(_titleView.mas_height);
        make.width.equalTo(_titleView.mas_width);
    }];
    [titleLabel layoutIfNeeded];
}

- (void)createCollectionView{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.minimumLineSpacing = 15.0f;
    flowLayout.minimumInteritemSpacing = 40.0f;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64.0f * 2) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_collectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    [self createTitleView];
    [self createCollectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PlayInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentify forIndexPath:indexPath];
    return cell;
}


@end
