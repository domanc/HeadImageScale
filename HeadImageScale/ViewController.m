//
//  ViewController.m
//  HeadImageScale
//
//  Created by Doman on 17/3/30.
//  Copyright © 2017年 doman. All rights reserved.
//

#import "ViewController.h"


static NSString *const kTableViewCell = @"UITableViewCell";
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIImageView *headImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class]
      forCellReuseIdentifier:kTableViewCell];
    
    
    UIView *titleView = [[UIView alloc] init];
    self.navigationItem.titleView = titleView;
    
    self.headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timg.jpg"]];
    self.headImageView.frame = CGRectMake(0, 0, 80, 80);
    self.headImageView.layer.cornerRadius = 40;
    self.headImageView.layer.masksToBounds = YES;
    //保证头像水平居中
    self.headImageView.center = CGPointMake(titleView.center.x, 0);
    [titleView addSubview:self.headImageView];

    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scale = 1.0;
    NSLog(@"y======%.2f---top======%.2f",scrollView.contentOffset.y,scrollView.contentInset.top);
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    NSLog(@"offsetY=======%.2f",offsetY);

    if (offsetY < 0) { // 放大
        // 允许下拉放大的最大距离为330
        // 1.5是放大的最大倍数
        // 这个值可以自由调整
        scale = MIN(1.5, 1 - offsetY / 330);
    } else if (offsetY > 0) { // 缩小
        // 允许向上超过导航条缩小的最大距离为330
        // 为了防止缩小过度，给一个最小值为0.50
        scale = MAX(0.50, 1 - offsetY / 330);
    }
    
    self.headImageView.transform = CGAffineTransformMakeScale(scale, scale);

    // 保证缩放后y坐标不变
    CGRect frame = self.headImageView.frame;
    frame.origin.y = -self.headImageView.layer.cornerRadius / 2;
    self.headImageView.frame = frame;

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableViewCell forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"cmd------%zd",indexPath.row];
    
    return cell;
}


@end
