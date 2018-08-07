//
//  AppConfigController.m
//  BlockChain
//
//  Created by nbs on 2018/7/19.
//  Copyright © 2018年 cn.nbs.block-chain. All rights reserved.
//

#import "AppConfigController.h" 

@interface AppConfigController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) WRCustomNavigationBar *customNavBar;
@end

@implementation AppConfigController

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[UITableViewCell className]];
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (_type) {
        case AppConfigTypeLanguage: {
            _dataSource = @[@"简体中文", @"繁体中文", @"English"];
        } break;
        case AppConfigTypeCurrency: {
            _dataSource = @[@"人民币", @"港币", @"美元"];
        } break;
    }
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self setupNavBar];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.customNavBar.mas_bottom);
    }];
    [self.view bringSubviewToFront:self.customNavBar];
}

- (void)setupNavBar {
    self.customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    [self.view addSubview:self.customNavBar];
    switch (_type) {
        case AppConfigTypeLanguage: {
            self.customNavBar.title = @"语言";
        } break;
        case AppConfigTypeCurrency: {
            self.customNavBar.title = @"货币";
        } break;
    } 
    self.customNavBar.titleLabelColor = kHexColor(0x333333);
    [self.customNavBar wr_setRightButtonWithTitle:@"保存" titleColor:kHexColor(0x3C8AFF)];
    [self.customNavBar setOnClickRightButton:^{
        
    }];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"nav_banck_black"]];
    [self.customNavBar updateFrame];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className] forIndexPath:indexPath];
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.accessoryType = UITableViewCellAccessoryNone;
    }];
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
}






@end
