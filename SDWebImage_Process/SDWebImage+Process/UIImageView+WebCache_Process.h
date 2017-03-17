//
//  UIImageView+WebCache2.h
//  YYKit_Demo
//
//  Created by YLCHUN on 16/12/28.
//  Copyright © 2016年 ylchun. All rights reserved.
//  SDWebImageProcessBlock  SDWebImage在完全获取到image添加后图片加工回调，然后将加工后的image进行缓存
//  processKey 区分不同的加工处理
//  processBlock 加工处理回调，返回加工结果

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"
#import "SDWebImageManager+Process.h"

@interface UIImageView (WebCache_Process)

- (void)sd_setImageWithURL:(NSURL *)url processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock ;


- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock ;

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock ;


- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock ;


- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock ;


- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock ;


- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock ;


@end
