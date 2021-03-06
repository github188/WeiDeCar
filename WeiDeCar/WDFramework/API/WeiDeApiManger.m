//
//  WeiDeApiManger.m
//  WeiDeCar
//
//  Created by mafanghua on 2017/12/7.
//  Copyright © 2017年 mafanghua. All rights reserved.
//

#import "WeiDeApiManger.h"

#define MFURL [WeiDeApiManger hostUrl]

#define MFURLWithPara(para) [MFURL stringByAppendingPathComponent:para]

NSString *const HttpWeiDeUrl = @"http://www.5weide.com:8080/better-api/";
NSString *const WeiDeUrl = @"http://111.230.170.243:8080/better-api/";
NSString *const test_WeiDeUrl = @"http://112.74.184.45:8080/better-api/";

@implementation WeiDeApiManger

//根据维修步骤ID查询图片接口
+(NSString *)listPhotoByRepairStepId
{
    return MFURLWithPara(@"api/diagnose/listPhotoByRepairStepId");
}

//维修步骤图片上传接口
+(NSString *)uploadRepairStepPhoto
{
    return MFURLWithPara(@"api/diagnose/uploadRepairStepPhoto");
}

//维修项目整体完成
+(NSString *)finishRepairItem
{
    return MFURLWithPara(@"api/diagnose/finishRepairItem");
}

//模拟支付成功接口
+(NSString *)repairPayTest
{
    return MFURLWithPara(@"api/diagnose/paySuccess");
}

//更新维修步骤状态，技师/专家可用
+(NSString *)updateRepairStep
{
    return MFURLWithPara(@"api/diagnose/updateRepairStep");
}

//获取维修项目步骤
+(NSString *)listRepairStep
{
    return MFURLWithPara(@"api/diagnose/listRepairStep");
}

//获取维修项目列表
+(NSString *)listRepairItem
{
    return MFURLWithPara(@"api/diagnose/listRepairItem");
}

//技师开始维修项目
+(NSString *)mechanicStartRepairItem
{
    return MFURLWithPara(@"api/diagnose/startRepairItem");
}

//根据用户ID查询维修任务列表
+(NSString *)listRepairTaskByUser
{
    return MFURLWithPara(@"api/diagnose/listRepairTaskByUser");
}

//车主选择维修项目报价接口
+(NSString *)chooseRepairItemOffers
{
    return MFURLWithPara(@"api/diagnose/chooseRepairItemOffers");
}

//获取维修项目报价
+(NSString *)listRepairItemOffers
{
    return MFURLWithPara(@"api/diagnose/listRepairItemOffers");
}

//获取修理厂列表
+(NSString *)listRepairFactories
{
    return MFURLWithPara(@"api/entity/listRepairFactories");
}

//获取七牛Token
+(NSString *)getQiniuToken
{
    return MFURLWithPara(@"api/integration/getQiniuToken");
}

//获取萤石平台AccessToken
+(NSString *)getYs7AccessToken
{
    return MFURLWithPara(@"api/integration/getYs7AccessToken");
}

//用户登录接口
+(NSString *)userLogin
{
    return MFURLWithPara(@"api/user/login");
}

//车主注册接口
+(NSString *)carOwnerRegister
{
    return MFURLWithPara(@"api/user/carOwnerRegister");
}

//车主创建维修任务接口
+(NSString *)createDiagnoseByCarOwner
{
    return MFURLWithPara(@"api/diagnose/createDiagnoseByCarOwner");
}

//技师诊断接口
+(NSString *)mechanicDiagnose
{
    return MFURLWithPara(@"api/diagnose/mechanicDiagnose");
}

//车主确认诊断结果接口
+(NSString *)confirmDiagnoseByCarOwner
{
    return MFURLWithPara(@"api/diagnose/confirmDiagnoseByCarOwner");
}

//专家诊断接口
+(NSString *)expertDiagnose
{
    return MFURLWithPara(@"api/diagnose/expertDiagnose");
}

//车主获取维修列表接口
+(NSString *)listDiagnoseByCarOwner
{
    return MFURLWithPara(@"api/diagnose/listDiagnoseByCarOwner");
}

//专家获取维修列表接口
+(NSString *)listDiagnoseByExpert
{
    return MFURLWithPara(@"api/diagnose/listDiagnoseByExpert");
}

//技师获取维修列表接口
+(NSString *)listDiagnoseByMechanic
{
    return MFURLWithPara(@"api/diagnose/listDiagnoseByMechanic");
}

//专家复诊后，用户重新确认
+(NSString *)reconfirmAfterExpertDiagnosed
{
    return MFURLWithPara(@"api/diagnose/reconfirmAfterExpertDiagnosed");
}

+ (NSString *)hostUrl
{
    if ([self packageIsAppStoreChannel]) {
        return WeiDeUrl;
    }
    
    return test_WeiDeUrl;
}

+(BOOL)packageIsAppStoreChannel
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSNumber *value = infoDictionary[@"AppStoreChannel"];
    if (value.boolValue) {
        return YES;
    }
    
    return NO;
}

@end
