//
//  WccyTaskTool.m
//  WccyTaskTool_Example
//
//  Created by JinYang on 2020/1/13.
//  Copyright © 2020 Wccy Team. All rights reserved.
//

#import "WccyTaskTool.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "MJExtension.h"
/*! 使用枚举NS_ENUM:区别可判断编译器是否支持新式枚举,支持就使用新的,否则使用旧的 */
typedef NS_ENUM(NSUInteger, WccyNetWorkStatus)
{
    /*! 未知网络 */
    WccyNetWorkStatusUnknown           = 0,
    /*! 没有网络 */
    WccyNetWorkStatusNotReachable,
    /*! 手机 3G/4G 网络 */
    WccyNetWorkStatusReachableViaWWAN,
    /*! wifi 网络 */
    WccyNetWorkStatusReachableViaWiFi
};

/*! 实时监测网络状态的 block */
typedef void(^WccyNetWorkBlock)(WccyNetWorkStatus status);

@interface WccyTaskTool ()

@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;


@end

@implementation WccyTaskTool

+ (instancetype)sharedTaskTool
{
    /*! 为单例对象创建的静态实例，置为nil，因为对象的唯一性，必须是static类型 */
    static id sharedTaskTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTaskTool = [[super allocWithZone:NULL] init];
    });
    return sharedTaskTool;
}

+ (void)initialize
{
    [self setupTaskTool];
}

+ (void)setupTaskTool{
    
    [WccyTaskTool sharedTaskTool].sessionManager = [AFHTTPSessionManager manager];
    /*! 打开状态栏的等待菊花 */
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [WccyTaskTool sharedTaskTool].sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];//请求
    
    [WccyTaskTool sharedTaskTool].sessionManager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    [WccyTaskTool sharedTaskTool].sessionManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    /*! 默认请求超时时间15s */
    [WccyTaskTool sharedTaskTool].sessionManager.requestSerializer.timeoutInterval = 15;
    /*! responseSerializer */
    [WccyTaskTool sharedTaskTool].sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    /*! 响应的结构体 */
    [WccyTaskTool sharedTaskTool].sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/css", @"text/xml", @"text/plain", @"application/javascript", @"application/x-www-form-urlencoded", @"image/*", nil];
}

+ (void)sendTask:(NSString *)url params:(NSDictionary *)params success:(WccySuccess)success failure:(WccyFailure)failure{
    /*! 网络检测 */
    [WccyTaskTool startMonitorNetWork:^(WccyNetWorkStatus status) {
        if (status==AFNetworkReachabilityStatusUnknown||AFNetworkReachabilityStatusNotReachable) {
            /*! 无网络 */
        }else{
            WccyTaskConfig *config = [WccyTaskTool sharedTaskTool].config;
            WccyPublicparameter *publicparameter = [WccyTaskTool sharedTaskTool].publicparameter;
            if (publicparameter) {
                publicparameter.dataBody=[params mutableCopy];
                publicparameter.method=url;
            }
            [[WccyTaskTool sharedTaskTool].sessionManager POST:publicparameter?config.formalService:[NSString stringWithFormat:@"%@%@",config.formalService,url] parameters:publicparameter?[publicparameter mj_keyValues]:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseObject) {
                    success(responseObject);
                }
                
                if (config.isOpenLog) {
                    /*! 打印参数 */
                    NSLog(@"sendTask参数 --- %@\n 结果 responseObject -  %@",publicparameter?[publicparameter mj_keyValues]:params,responseObject);
                }
                
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    failure(error);
                }
                
                if (config.isOpenLog) {
                    /*! 打印参数 */
                    NSLog(@"sendTask参数 --- %@\n 结果 error --- %@",publicparameter?[publicparameter mj_keyValues]:params,error);
                }
                
            }];
        }
    }];
}

+ (void)obtainTask:(NSString *)url params:(NSDictionary *)params success:(WccySuccess)success failure:(WccyFailure)failure{
    /*! 网络检测 */
    [WccyTaskTool startMonitorNetWork:^(WccyNetWorkStatus status) {
        if (status==AFNetworkReachabilityStatusUnknown||AFNetworkReachabilityStatusNotReachable) {
            /*! 无网络 */
        }else{
            WccyTaskConfig *config = [WccyTaskTool sharedTaskTool].config;
            WccyPublicparameter *publicparameter = [WccyTaskTool sharedTaskTool].publicparameter;
            if (publicparameter) {
                publicparameter.dataBody=params.mutableCopy;
                publicparameter.method=url;
            }
            [[WccyTaskTool sharedTaskTool].sessionManager GET:publicparameter?config.formalService:[NSString stringWithFormat:@"%@%@",config.formalService,url] parameters:publicparameter?[publicparameter mj_keyValues]:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if (responseObject) {
                    success(responseObject);
                }
                
                if (config.isOpenLog) {
                    /*! 打印参数 */
                    NSLog(@"obtainTask参数 --- %@\n 结果 responseObject -  %@",publicparameter?[publicparameter mj_keyValues]:params,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (error) {
                    failure(error);
                }
                
                if (config.isOpenLog) {
                    /*! 打印参数 */
                    NSLog(@"obtainTask参数 --- %@\n 结果 error --- %@",publicparameter?[publicparameter mj_keyValues]:params,error);
                }
            }];
        }
    }];
}

+ (void)startMonitorNetWork:(WccyNetWorkBlock)workStatus{
    /*! 1.获得网络监控的管理者 */
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /*! 当使用AF发送网络请求时,只要有网络操作,那么在状态栏(电池条)wifi符号旁边显示  菊花提示 */
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    WccyTaskConfig *config = [WccyTaskTool sharedTaskTool].config;
    /*! 2.设置网络状态改变后的处理 */
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*! 当网络状态改变了, 就会调用这个block */
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown:
                if (config.isOpenLog) {
                    NSLog(@"未知网络");
                }
                workStatus ? workStatus(WccyNetWorkStatusUnknown) : nil;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                if (config.isOpenLog) {
                    NSLog(@"没有网络");
                }
                workStatus ? workStatus(WccyNetWorkStatusNotReachable) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if (config.isOpenLog) {
                    NSLog(@"手机自带网络");
                }
                workStatus ? workStatus(WccyNetWorkStatusReachableViaWWAN) : nil;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if (config.isOpenLog) {
                    NSLog(@"wifi 网络");
                }
                workStatus ? workStatus(WccyNetWorkStatusReachableViaWiFi) : nil;
                break;
        }
    }];
    [manager startMonitoring];
}

@end


@implementation WccyTaskConfig 

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval{
    _timeoutInterval = timeoutInterval;
    
    [WccyTaskTool sharedTaskTool].sessionManager.requestSerializer.timeoutInterval = timeoutInterval;
}

- (void)setHttpHeaderFieldDictionary:(NSDictionary *)httpHeaderFieldDictionary{
    _httpHeaderFieldDictionary = httpHeaderFieldDictionary;
    if (![httpHeaderFieldDictionary isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"请求头数据有误，请检查！");
        return;
    }
    NSArray *keyArray = httpHeaderFieldDictionary.allKeys;
    
    if (keyArray.count <= 0)
    {
        NSLog(@"请求头数据有误，请检查！");
        return;
    }
    
    for (NSInteger i = 0; i < keyArray.count; i ++)
    {
        NSString *keyString = keyArray[i];
        NSString *valueString = httpHeaderFieldDictionary[keyString];
        [[WccyTaskTool sharedTaskTool].sessionManager.requestSerializer setValue:valueString forHTTPHeaderField:keyString];
    }
}

@end


@implementation WccyPublicparameter

@end
