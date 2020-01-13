//
//  WccyTaskTool.h
//  WccyTaskTool_Example
//
//  Created by JinYang on 2020/1/13.
//  Copyright © 2020 Wccy Team. All rights reserved.
//  网络处理工具

/******
 友情提醒：
 1.菊花转圈和tips未放进此网络组件里，若需要建议做成颗粒组件配合使用
 
 
 *******/


#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

/// 成功回调
typedef void (^WccySuccess)(id response);
/// 失败回调
typedef void (^WccyFailure) (NSError *error);


@class WccyTaskConfig,WccyPublicparameter;

@interface WccyTaskTool : NSObject

/*!
 *  获得全局唯一的网络请求实例单例方法
 *
 *  @return 网络请求类sharedTaskTool单例
 */
+ (instancetype)sharedTaskTool;


/// 全局配置信息
@property (nonatomic,strong) WccyTaskConfig *config;

/// 全局配置公参
@property (nonatomic,strong) WccyPublicparameter *publicparameter;


/// 使用【POST】请求数据
/// @param url 接口
/// @param params 参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)sendTask:(NSString *)url  params:(NSDictionary *)params success:(WccySuccess)success failure:(WccyFailure)failure;

/// 使用【GET】请求数据
/// @param url 接口
/// @param params 参数
/// @param success 成功回调
/// @param failure 失败回调
+ (void)obtainTask:(NSString *)url  params:(NSDictionary *)params success:(WccySuccess)success failure:(WccyFailure)failure;

@end


/***网络配置相关***/
@interface WccyTaskConfig : NSObject

/// 创建的请求的超时间隔（以秒为单位），此设置为全局统一设置一次即可，默认超时时间间隔为15秒。
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/// 主机地址
@property (nonatomic, copy) NSString *formalService;

/// 自定义请求头：httpHeaderField
@property(nonatomic, strong) NSDictionary *httpHeaderFieldDictionary;

/// 是否开启 log 打印，默认不开启
@property(nonatomic, assign) BOOL isOpenLog;


@end


/***公参【只针对本公司使用，请忽略】***/
@interface WccyPublicparameter : NSObject

/// 身份核实令牌
@property (nonatomic, copy) NSString *token;

/// 版本号
@property (nonatomic, copy) NSString *version;

/// 用于包装WccyTaskTool中的外层params
@property (nonatomic, copy) NSMutableDictionary *dataBody;

/// 用户包装WccyTaskTool中的外层url
@property (nonatomic, copy) NSString *method;


@end


NS_ASSUME_NONNULL_END
