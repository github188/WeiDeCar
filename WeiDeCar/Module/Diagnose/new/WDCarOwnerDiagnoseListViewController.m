//
//  WDCarOwnerDiagnoseListViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/3/26.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDCarOwnerDiagnoseListViewController.h"

@interface WDCarOwnerDiagnoseListViewController ()

@end

@implementation WDCarOwnerDiagnoseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"现场诊断-车主";
    
    [self initCreateHeaderView];
    
    [self initTableView];
    
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(m_createDiagnoseView.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    __weak typeof(self) weakSelf = self;
    [m_tableView addPullToRefreshWithActionHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf getListDiagnoseByCarOwner];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getListDiagnoseByCarOwner];
}

-(void)initCreateHeaderView
{
    m_createDiagnoseView = [WDDiagnosisMainAddView nibView];
    m_createDiagnoseView.m_delegate = self;
    [self.view addSubview:m_createDiagnoseView];
    [m_createDiagnoseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(64);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(60);
    }];
    
    UIView *separator = [UIView new];
    separator.backgroundColor = MFCustomLineColor;
    [m_createDiagnoseView addSubview:separator];
    [separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(m_createDiagnoseView.mas_bottom);
        make.width.equalTo(m_createDiagnoseView.mas_width);
        make.height.mas_equalTo(MFOnePixHeight);
    }];
}

-(void)getListDiagnoseByCarOwner
{
    __weak typeof(self) weakSelf = self;
    WDListDiagnoseByCarOwnerApi *mfApi = [WDListDiagnoseByCarOwnerApi new];
    mfApi.carOwnerId = m_currentUserInfo.userId;
    
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        [m_tableView.pullToRefreshView stopAnimating];
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        NSArray *diagnoses = mfApi.responseNetworkData;
        NSMutableArray *diagnoseArray = [NSMutableArray array];
        for (int i = 0; i < diagnoses.count; i++) {
            WDDiagnoseModel *itemModel = [WDDiagnoseModel yy_modelWithDictionary:diagnoses[i]];
            [diagnoseArray addObject:itemModel];
        }
        
        m_diagnoseArray = diagnoseArray;
        
        [strongSelf reloadTableView];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_diagnoseArray.count; i++) {
        MFTableViewCellObject *diagnoseModel = [MFTableViewCellObject new];
        diagnoseModel.cellHeight = 150.0f;
        diagnoseModel.cellReuseIdentifier = @"diagnoseItem";
        diagnoseModel.attachIndex = i;
        [m_cellInfos addObject:diagnoseModel];
        
        MFTableViewCellObject *separator = [MFTableViewCellObject new];
        separator.cellHeight = MFOnePixHeight;
        separator.cellReuseIdentifier = @"separator";
        separator.attachIndex = i;
        [m_cellInfos addObject:separator];
    }
}

#pragma mark - WDDiagnosisMainAddViewDelegate
-(void)onClickAddNewRecord:(WDDiagnosisMainAddView *)view
{
    __weak typeof(self) weakSelf = self;
    WDCreateDiagnoseByCarOwnerApi *mfApi = [WDCreateDiagnoseByCarOwnerApi new];
    mfApi.carOwnerId = m_currentUserInfo.userId;
    mfApi.animatingText = @"正在创建维修任务...";
    mfApi.animatingView = MFAppWindow;
    [mfApi startWithCompletionBlockWithSuccess:^(YTKBaseRequest * request) {
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!mfApi.messageSuccess) {
            [strongSelf showTips:mfApi.errorMessage];
            return;
        }
        
        [strongSelf getListDiagnoseByCarOwner];
        
    } failure:^(YTKBaseRequest * request) {
        
    }];
}

- (void)handleJPUSHServiceNotification:(NSNotification *)notification {
    [self getListDiagnoseByCarOwner];
}

#pragma mark - WDDiagnoseItemCellViewDelegate
-(void)onClickDiagnoseItemCellView:(WDDiagnoseModel *)itemModel
{
    NSLog(@"onClickDiagnoseItemCellView");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end