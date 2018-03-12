//
//  WDRepairStepUploadImageCellView.h
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/11.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "MMUIBridgeView.h"
#import "WDRepairStepModel.h"

@class WDRepairStepModel,WDRepairStepUploadImageCellView;
@protocol WDRepairStepUploadImageCellViewDelegate <NSObject>
@optional
-(void)onClickUploadImageRepairStep:(WDRepairStepModel *)repairStep cellView:(WDRepairStepUploadImageCellView *)cellView;

@end

@interface WDRepairStepUploadImageCellView : MMUIBridgeView
{
    UIImageView *m_imageView;
    UIButton *m_contentButton;
    
    WDRepairStepModel *m_repairStep;
}

@property (nonatomic,weak) id<WDRepairStepUploadImageCellViewDelegate> m_delegate;

-(void)setRepairStepModel:(WDRepairStepModel *)repairStep;

@end
