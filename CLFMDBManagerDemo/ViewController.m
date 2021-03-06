//
//  ViewController.m
//  CLFMDBManagerDemo
//
//  Created by 炬盈科技 on 2017/11/8.
//  Copyright © 2017年 github/cjq002. All rights reserved.
//

#import "ViewController.h"
#import "CLFMDBManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // FIXME : 没有页面，看数据库文件，看打印数据
    
    // 必须调用，开始就创建数据表
    [[CLFMDBManager manager] createTableArray:@[kFmdbTableName]
                              primaryKeyArray:@[kPrimaryKey]];
    
    
    // 插入随机数据
    [self insertRandomData];
    
    // 更新指定主键数据
    [self updateData:@"10"];
    
    // 删除指定主键数据
    [self deleteData:@"54"];
    
    // 查询所有数据
    [[CLFMDBManager manager] selectDataWithTable:kFmdbTableName conditions:nil withBlock:^(NSArray<NSDictionary *> *resultSets) {
        for (NSDictionary *result in resultSets) {
            NSLog(@"%@", result);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 插入随机数据
- (void)insertRandomData {
    NSDictionary *dictionary = @{kPrimaryKey : [NSString stringWithFormat:@"%d", arc4random()% 100],
                                 @"Name" : [NSString stringWithFormat:@"名称：%d", arc4random()% 100],
                                 @"Remarks" : [NSString stringWithFormat:@"备注：%d", arc4random()% 100],
                                 };
    [[CLFMDBManager manager] insertDataWithTable:kFmdbTableName
                                      primaryKey:kPrimaryKey
                                      dictionary:dictionary
                                       withBlock:^(FMDatabase *db, BOOL successful) {
                                           if (successful) {
                                               NSLog(@"成功");
                                           }else{
                                               NSLog(@"失败");
                                           }
                                       }];
    [[CLFMDBManager manager] selectDataWithTable:kFmdbTableName primaryKey:kPrimaryKey primaryValue:@"36" withBlock:^(NSArray<NSDictionary *> *resultSets) {
        for (NSDictionary *result in resultSets) {
            NSLog(@"%@", result);
        }
    }];
}

#pragma mark 更新指定主键数据
- (void)updateData:(NSString *)primaryKey {
    NSDictionary *dictionary = @{kPrimaryKey : primaryKey,
                                 @"Name" : [NSString stringWithFormat:@"名称：%d", 80],
                                 @"Remarks" : [NSString stringWithFormat:@"备注：%d", 90],
                                 };
    [[CLFMDBManager manager] updateDataWithTable:kFmdbTableName primaryKey:kPrimaryKey dictionary:dictionary withBlock:^(FMDatabase *db, BOOL successful) {
        if (successful) {
            NSLog(@"成功");
        }else{
            NSLog(@"失败");
        }
    }];
}

#pragma mark 删除指定主键数据
- (void)deleteData:(NSString *)primaryKey {
    [[CLFMDBManager manager] deleteDataWithTable:kFmdbTableName primaryKey:kPrimaryKey primaryValue:primaryKey withBlock:^(FMDatabase *db, BOOL successful) {
        if (successful) {
            NSLog(@"成功");
        }else{
            NSLog(@"失败");
        }
    }];
}

- (void)deleteAllData {
    [[CLFMDBManager manager] deleteAllDataWithTable:kFmdbTableName withBlock:^(FMDatabase *db, BOOL successful) {
        if (successful) {
            NSLog(@"成功");
        }else{
            NSLog(@"失败");
        }
    }];
}

@end

