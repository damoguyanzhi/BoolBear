//
//  AFNetworkingViewController.m
//  BoolBear
//
//  Created by RuqiangLiu on 2019/8/13.
//  Copyright © 2019 RuqiangLiu. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import <AFNetworking.h>
#import <UIKit+AFNetworking.h>

@interface AFNetworkingViewController ()

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //post请求参数一般用字典，键要与请求url的参数名一致。
//    [manager POST:@"example" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//        //进度
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        //成功
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        //失败
//    }];
}



@end
