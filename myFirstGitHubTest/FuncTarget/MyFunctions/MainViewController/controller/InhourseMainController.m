//
//  InhourseMainController.m
//  FuncTarget
//
//  Created by 程昂 on 2017/3/7.
//  Copyright © 2017年 程昂. All rights reserved.
//

#import "InhourseMainController.h"
#import "mainControllerDisplayModel.h"

@interface InhourseMainController ()
{
    UIView *_titleView;
}
@end

@implementation InhourseMainController

static NSString * const titleInfo = @"内测版";

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}

- (void)createTitleView{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60.0f, 7.0f, [UIScreen mainScreen].bounds.size.width-120.0f, 30.0f)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:15.0f];
    titleLabel.text = titleInfo;
    self.navigationItem.titleView = titleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    [self createTitleView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
