//
//  HQHomeView.m
//  HQAppArchitectureDemo
//
//  Created by Mr_Han on 2018/12/4.
//  Copyright © 2018 Mr_Han. All rights reserved.
//  CSDN <https://blog.csdn.net/u010960265>
//  GitHub <https://github.com/HanQiGod>
//


#import "HQHomeView.h"
#import "HQHomeListCell.h"

static NSString * const kIdentifierOfYBHomeListCell = @"kIdentifierOfYBHomeListCell";

@interface HQHomeView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSMutableArray<HQHomeListModel *> *homeListDataArray;
@end

@implementation HQHomeView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        
        [self.tableView.mj_header beginRefreshing];
    }
    return self;
}

- (void)initViews {
    [self addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - public

- (void)requestHomeListSuccessWithArray:(NSArray<HQHomeListModel *> *)array {
    if (array.count > 0) {
        if (self.currentPage == 0) {
            [self.homeListDataArray removeAllObjects];
        }
        [self.homeListDataArray addObjectsFromArray:array];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } else {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    [self.tableView.mj_header endRefreshing];
}

- (void)requestHomeListFailed {
    self.currentPage = 0;
    [self.homeListDataArray removeAllObjects];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - <UITableViewDataSource, UITableViewDelegate>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.homeListDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HQHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:kIdentifierOfYBHomeListCell];
    cell.model = self.homeListDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableView HQGeneral_configuration];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:HQHomeListCell.class forCellReuseIdentifier:kIdentifierOfYBHomeListCell];
        _tableView.tableFooterView = [UIView new];
        
        @weakify(self);
        [_tableView HQGeneral_addRefreshHeader:^{
            @strongify(self);
            self.currentPage = 0;
            [self.delegate homeView:self requestHomeListWithPage:self.currentPage];
        } footer:^{
            @strongify(self);
            ++self.currentPage;
            [self.delegate homeView:self requestHomeListWithPage:self.currentPage];
        }];
    }
    return _tableView;
}

- (NSUInteger)currentPage {
    if (!_currentPage) {
        _currentPage = 0;
    }
    return _currentPage;
}

- (NSMutableArray<HQHomeListModel *> *)homeListDataArray {
    if (!_homeListDataArray) {
        _homeListDataArray = [NSMutableArray array];
    }
    return _homeListDataArray;
}

@end

