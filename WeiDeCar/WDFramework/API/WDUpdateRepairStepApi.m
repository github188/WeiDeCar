//
//  WDUpdateRepairStepApi.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/12.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDUpdateRepairStepApi.h"

@implementation WDUpdateRepairStepApi

-(NSString *)requestUrl
{
    return [WeiDeApiManger updateRepairStep];
}

-(id)requestArgumentWithToken
{
    NSMutableDictionary *requestArgument = [NSMutableDictionary dictionary];
    requestArgument[@"userId"] = self.userId;
    requestArgument[@"repairStepId"] = self.repairStepId;
    
    if (self.canOperateQualified)
    {
        requestArgument[@"onsiteQualified"] = self.onsiteQualified;
        requestArgument[@"thirdPartyQualified"] = self.thirdPartyQualified;
    }
    
    return requestArgument;
}

@end
