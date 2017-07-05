//
//  ManagerAFNetworking.m
// 
//
//  Created by xuanvinhtd on 7/5/17.
//  Copyright © 2017 xuanvinhtd. All rights reserved.
//
// USING FOR AFNetworking 3x
#import "ManagerAFNetworking.h"
#import <AFHTTPSessionManager.h>

@implementation ManagerAFNetworking
+ (ManagerAFNetworking *)share {
  static ManagerAFNetworking *_instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _instance = [[self alloc] init];
    _instance.manager = [AFHTTPSessionManager manager];
    //--- USING REQUEST HTTPS
    _instance.manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    [_instance.manager.securityPolicy setAllowInvalidCertificates:YES];
    [_instance.manager.securityPolicy setValidatesDomainName:NO];
    //----
    _instance.manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    _instance.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // ADD HEADER REQUEST
    /*[manager.requestSerializer setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"punch" forHTTPHeaderField:@"App-Type"];
    [manager.requestSerializer setValue:IS_IPAD?@"tablet":@"phone" forHTTPHeaderField:@"Device"];
    [manager.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Device-Type"];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lu",(unsigned long)myData.length] forHTTPHeaderField:@"Content-Length"];
    [manager.requestSerializer setValue:self.userAgent forHTTPHeaderField:@"User-Agent"];
     */
  });
  return _instance;
}
- (void)requestWithAPI:(NSString *)strAPI completed:(Completed)completion {
  NSDictionary *parameter = @{};
  [self.manager POST:strAPI parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
    NSLog(@"PROGRESS == %@",uploadProgress);
    completion(NO, nil, nil, nil);
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"SUCCESS == %@", responseObject);
    completion(YES, nil, nil, nil);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"ERROR == %@", error);
    completion(NO, nil, nil, nil);
  }];
  
  /*[manager GET:strAPI parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
  } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSLog(@"SUCCESS == %@", responseObject);
    NSError *jsonError = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:kNilOptions error:&jsonError];
    NSLog(@"SUCCESS JSON == %@", json);
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    NSLog(@"ERROR == %@", error);
  }];*/
}
@end
