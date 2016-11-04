//
//  FMDBTool.h
//  GlobalTravel
//
//  Created by john.zhang on 16/10/29.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TravelingHealthModel.h"
#import "TravelingTipsModel.h"
#import "FacilitiesModel.h"
#import "HikingModel.h"

@interface FMDBTool : NSObject


#pragma mark TravelingTips

//添加
+(void)addTravilingTips:(TravelingTipsModel *)model;

//删除
+(void)deleteTravilingTips:(TravelingTipsModel *)model;

//查找
+(NSArray *)searchTraviling;


#pragma mark TravelHealth

//添加
+(void)addTravelHealth:(TravelingHealthModel *)model;

//删除
+(void)deleteTravelHealth:(TravelingHealthModel *)model;

//查找
+(NSArray *)searchTravelHealth;

#pragma mark Travelfacilities 旅行工具

//添加
+(void)addTravelfacilities:(FacilitiesModel *)model;

//删除
+(void)deleteTravelfacilities:(FacilitiesModel *)model;

//查找
+(NSArray *)searchTravelfacilities;

#pragma mark Hiking

//添加
+(void)addHiking:(HikingModel *)model;

//删除
+(void)deleteHiking:(HikingModel *)model;

//查找
+(NSArray *)searchHiking;


@end
