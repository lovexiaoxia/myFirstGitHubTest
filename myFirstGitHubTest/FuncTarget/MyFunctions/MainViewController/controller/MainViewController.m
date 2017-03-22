//
//  MainViewController.m
//  cocoaPodsTestDemo
//
//  Created by 程昂 on 2017/3/6.
//  Copyright © 2017年 程昂. All rights reserved.
//

#import "MainViewController.h"
#import "Masonry.h"
#import "mainControllerDisplayModel.h"
#import "InhourseMainController.h"

@interface MainViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UIView *_title;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation MainViewController

static NSString * const titleInfo = @"对外版";
static NSString *const cellIndenty = @"cellIndenty";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)createTitleView{
//    _title = [UIView new];
//    _title.backgroundColor = [UIColor clearColor];
//    
//    [self.navigationItem.titleView addSubview:_title];
//    
//    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(@0);
//        make.left.mas_equalTo(@0);
//        make.right.mas_equalTo(@0);
//        make.height.mas_equalTo(@64);
//    }];
//    [_title layoutIfNeeded];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 7.0f, [UIScreen mainScreen].bounds.size.width-120.0f, 30.0f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    titleLabel.text = self.model.titleString;
    self.navigationItem.titleView = titleLabel;
    
//    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.navigationItem.titleView);
//        make.left.mas_equalTo(@0);
//        make.right.mas_equalTo(@0);
//        make.top.mas_equalTo(@0);
//        make.bottom.mas_equalTo(@0);
//    }];
//    [titleLabel layoutIfNeeded];
}

- (void)createNoticeButton{
    UIButton *noticeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [noticeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [noticeBtn setTitle:self.model.btnTitleString forState:UIControlStateNormal];
    [noticeBtn addTarget:self action:@selector(sendLocalNotice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:noticeBtn];
    
    [noticeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@30);
        make.top.equalTo(self.view).mas_equalTo(@100);
    }];
    [noticeBtn layoutIfNeeded];
    
    //UILabel *centerLabel = [UILabel new];
    //centerLabel.backgroundColor = [UIColor greenColor];
    
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor grayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@"1",@"2",@"3",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",@"2",];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self createTitleView];
    [self createNoticeButton];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.left.mas_equalTo(@0);
        make.right.mas_equalTo(@0);
        make.bottom.mas_equalTo(@0);
        
    }];
    NSLog(@"frame:%@",NSStringFromCGRect(self.view.frame));
    NSLog(@"screen:%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"frame:%@",NSStringFromCGRect(self.view.frame));
    NSLog(@"screen:%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)sendLocalNotice{
    
    
#ifdef DEBUG
    NSLog(@"debug模式");
#else
    NSLog(@"非debug模式");
#endif
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndenty];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndenty];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor greenColor];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InhourseMainController *controller = [[InhourseMainController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
