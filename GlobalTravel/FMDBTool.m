//
//  FMDBTool.m
//  GlobalTravel
//
//  Created by john.zhang on 16/10/29.
//  Copyright © 2016年 john.zhang. All rights reserved.
//

#import "FMDBTool.h"
#import "FMDB.h"

@implementation FMDBTool


static FMDatabase *_db;
NSString *_path;


//只会在当前类第一次使用的时候调用
+(void)initialize
{
    
    //创建路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    
    _path = [doc stringByAppendingPathComponent:@"Collecting.sqlite"];
    NSLog(@"%@",_path);
    
    //根据路径创建一个FMDatabase对象
    _db=[FMDatabase databaseWithPath:_path];
    
    //打开数据库
    if ([_db open]) {
        NSLog(@"打开数据库成功");
        
        //创建旅行攻略表
        int result5 = [_db executeUpdate:@"create table if not exists TravelingTips(t text,n text,p text,fromurl text);"];
        if (result5) {
            NSLog(@"TravelingTips建表成功");
        }else
        {
            NSLog(@"TravelingTips建表失败");
        }
        
        //创建旅行健康表
        int result6 = [_db executeUpdate:@"create table if not exists TravelingHealth(t text,n text,p text,fromurl text,data text,url text);"];
        if (result6) {
            NSLog(@"TravelingHealth建表成功");
        }else
        {
            NSLog(@"TravelingHealth建表失败");
            NSLog(@"错误%d",result6);
        }
        
        //创建旅行工具表
        int result7 = [_db executeUpdate:@"create table if not exists Travelfacilities(t text,n text,p text,fromurl text);"];
        if (result7) {
            NSLog(@"Travelfacilities建表成功");
        }else
        {
            NSLog(@"Travelfacilities建表失败");
            NSLog(@"错误%d",result6);
        }
        
        //创建徒步旅行表
        int result8 = [_db executeUpdate:@"create table if not exists Hiking(t text,n text,p text,fromurl text,data text,url text);"];
        if (result8) {
            NSLog(@"Hiking建表成功");
        }else
        {
            NSLog(@"Hiking建表失败");
            NSLog(@"错误%d",result6);
        }
        
            //创建视频表
        int result = [_db executeUpdate:@"create table if not exists Vedio(avatar text,screen_name text,recommend_caption text,cover_pic text,VideoUrl text,caption text);"];
        if (result) {
            NSLog(@"Vedio建表成功");
        }else
        {
            NSLog(@"Vedio建表失败");
            NSLog(@"错误%d",result);
        }

        
        }else
    {
        NSLog(@"打开数据库失败");
    }

    [_db close];
    
}

#pragma mark TravelingTips

//添加
+(void)addTravilingTips:(TravelingTipsModel *)model
{
    [_db open];
    //不确定的参数用？但是后面必须是OC对象
    int result =   [_db executeUpdate:@"INSERT INTO TravelingTips(t,n,p,fromurl) values(?,?,?,?);",model.t,model.n,model.p,model.fromurl];
    if (result) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
    [_db close];
}

//删除
+(void)deleteTravilingTips:(TravelingTipsModel *)model
{
    [_db open];
    int result =[_db executeUpdate:@"DELETE FROM TravelingTips WHERE fromurl = ?",model.fromurl];
    if (result) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
        
    }
    [_db close];
}

//查找
+(NSArray *)searchTraviling
{
    [_db open];
    //返回值是一个结果集
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM TravelingTips"];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    //遍历结果集
    while ([resultSet next]) {
        
        TravelingTipsModel *model = [[TravelingTipsModel alloc]init];
        model.t = [resultSet objectForColumnName:@"t"];
        model.n = [resultSet objectForColumnName:@"n"];
        model.p = [resultSet objectForColumnName:@"p"];
        model.fromurl = [resultSet objectForColumnName:@"fromurl"];
        
        [dataArray addObject:model];
        //        NSLog(@"title = %@,pic = %@,url = %@",model.title,model.pic,model.url);
    }
    [_db close];
    
    return [dataArray copy];
}

#pragma mark TravelHealth

//添加
+(void)addTravelHealth:(TravelingHealthModel *)model
{
    [_db open];
    //不确定的参数用？但是后面必须是OC对象
    int result =   [_db executeUpdate:@"INSERT INTO TravelingHealth(t,n,p,fromurl,data,url) values(?,?,?,?,?,?);",model.t,model.n,model.p,model.fromurl,model.date,model.from];
    if (result) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
    [_db close];
}

//删除
+(void)deleteTravelHealth:(TravelingHealthModel *)model
{
    [_db open];
    int result =[_db executeUpdate:@"DELETE FROM TravelingHealth WHERE fromurl = ?",model.fromurl];
    if (result) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
        
    }
    [_db close];
    
}

//查找
+(NSArray *)searchTravelHealth
{
    [_db open];
    //返回值是一个结果集
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM TravelingHealth"];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    //遍历结果集
    while ([resultSet next]) {
        
        TravelingHealthModel *model = [[TravelingHealthModel alloc]init];
        model.t = [resultSet objectForColumnName:@"t"];
        model.n = [resultSet objectForColumnName:@"n"];
        model.p = [resultSet objectForColumnName:@"p"];
        model.fromurl = [resultSet objectForColumnName:@"fromurl"];
        model.date = [resultSet objectForColumnName:@"data"];
        model.from = [resultSet objectForColumnName:@"url"];
        [dataArray addObject:model];
    }
    [_db close];
    
    return [dataArray copy];
}

#pragma mark Travelfacilities 旅行工具

//添加
+(void)addTravelfacilities:(FacilitiesModel *)model{
    
    [_db open];
    //不确定的参数用？但是后面必须是OC对象
    int result =   [_db executeUpdate:@"INSERT INTO Travelfacilities(t,n,p,fromurl) values(?,?,?,?);",model.t,model.n,model.p,model.fromurl];
    if (result) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
    [_db close];
}

//删除
+(void)deleteTravelfacilities:(FacilitiesModel *)model{
    [_db open];
    int result =[_db executeUpdate:@"DELETE FROM Travelfacilities WHERE fromurl = ?",model.fromurl];
    if (result) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
        
    }
    [_db close];

}

//查找
+(NSArray *)searchTravelfacilities{
    [_db open];
    //返回值是一个结果集
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM Travelfacilities"];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    //遍历结果集
    while ([resultSet next]) {
        
        FacilitiesModel *model = [[FacilitiesModel alloc]init];
        model.t = [resultSet objectForColumnName:@"t"];
        model.n = [resultSet objectForColumnName:@"n"];
        model.p = [resultSet objectForColumnName:@"p"];
        model.fromurl = [resultSet objectForColumnName:@"fromurl"];
        
        [dataArray addObject:model];
        //        NSLog(@"title = %@,pic = %@,url = %@",model.title,model.pic,model.url);
    }
    [_db close];
    
    return [dataArray copy];
}

#pragma mark Hiking

//添加
+(void)addHiking:(HikingModel *)model
{
    [_db open];
    //不确定的参数用？但是后面必须是OC对象
    int result =   [_db executeUpdate:@"INSERT INTO Hiking(t,n,p,fromurl,data,url) values(?,?,?,?,?,?);",model.t,model.n,model.p,model.fromurl,model.date,model.from];
    if (result) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
    [_db close];

}

//删除
+(void)deleteHiking:(HikingModel *)model
{
    [_db open];
    int result =[_db executeUpdate:@"DELETE FROM Hiking WHERE fromurl = ?",model.fromurl];
    if (result) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
        
    }
    [_db close];
    

}

//查找
+(NSArray *)searchHiking
{
    [_db open];
    //返回值是一个结果集
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM Hiking"];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    //遍历结果集
    while ([resultSet next]) {
        
        HikingModel *model = [[HikingModel alloc]init];
        model.t = [resultSet objectForColumnName:@"t"];
        model.n = [resultSet objectForColumnName:@"n"];
        model.p = [resultSet objectForColumnName:@"p"];
        model.fromurl = [resultSet objectForColumnName:@"fromurl"];
        model.date = [resultSet objectForColumnName:@"data"];
        model.from = [resultSet objectForColumnName:@"url"];
        [dataArray addObject:model];
    }
    [_db close];
    
    return [dataArray copy];

}

#pragma mark Vedio
//添加
+(void)addVedio:(RelexMomentModel *)model
{
    //avatar text,screen_name text,recommend_caption text,cover_pic text,VideoUrl text
    [_db open];
    //不确定的参数用？但是后面必须是OC对象
    int result =   [_db executeUpdate:@"INSERT INTO Vedio(avatar ,screen_name ,recommend_caption ,cover_pic ,VideoUrl,caption) values(?,?,?,?,?,?);",model.avatar,model.screen_name,model.recommend_caption,model.cover_pic,model.VideoUrl,model.caption];
    if (result) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
    [_db close];
}

//删除
+(void)deleteVedio:(RelexMomentModel *)model
{
    [_db open];
    int result =[_db executeUpdate:@"DELETE FROM Vedio WHERE VideoUrl = ?",model.VideoUrl];
    if (result) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
        
    }
    [_db close];

}

//查找
+(NSArray *)searchVedio
{
    [_db open];
    //返回值是一个结果集
    FMResultSet *resultSet = [_db executeQuery:@"SELECT * FROM Vedio"];
    
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    //遍历结果集
    while ([resultSet next]) {
        //avatar ,screen_name ,recommend_caption ,cover_pic ,VideoUrl
        RelexMomentModel *model = [[RelexMomentModel alloc]init];
        model.avatar = [resultSet objectForColumnName:@"avatar"];
        model.screen_name = [resultSet objectForColumnName:@"screen_name"];
        model.recommend_caption = [resultSet objectForColumnName:@"recommend_caption"];
        model.cover_pic = [resultSet objectForColumnName:@"cover_pic"];
        model.VideoUrl = [resultSet objectForColumnName:@"VideoUrl"];
        model.caption= [resultSet objectForColumnName:@"caption"];
        [dataArray addObject:model];
    }
    [_db close];
    
    return [dataArray copy];

}




@end
