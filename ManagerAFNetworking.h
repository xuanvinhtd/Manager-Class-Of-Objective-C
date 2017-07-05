//
//  ManagerAFNetworking.h
//  
//
//  Created by xuanvinhtd on 7/5/17.
//  Copyright © 2017 xuanvinhtd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPSessionManager;
typedef void(^Completed)(BOOL success, NSString *error, NSString *info, NSDictionary *result);
@interface ManagerAFNetworking : NSObject
@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (ManagerAFNetworking *)share;
- (void)requestWithAPI:(NSString *)strAPI completed:(Completed)completion;
@end
