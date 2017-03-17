//
//  UIImageView+WebCache2.m
//  YYKit_Demo
//
//  Created by YLCHUN on 16/12/28.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "UIImageView+WebCache_Process.h"

#import "objc/runtime.h"

static char imageURLKey_Process;

@interface UIImageView (Process)

- (BOOL)showActivityIndicatorView;
- (void)addActivityIndicator;
- (void)removeActivityIndicator;
- (void)sd_setImageLoadOperation:(id)operation forKey:(NSString *)key;

@end

@implementation UIImageView (WebCache_Process)

- (void)sd_setImageWithURL:(NSURL *)url processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock {
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:nil processKey:processKey processBlock:processBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:nil processKey:processKey processBlock:processBlock] ;
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:nil processKey:processKey processBlock:processBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url completed:(SDWebImageCompletionBlock)completedBlock processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock{
    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:nil completed:completedBlock processKey:processKey processBlock:processBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(SDWebImageCompletionBlock)completedBlock processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:nil completed:completedBlock processKey:processKey processBlock:processBlock];
}

- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options completed:(SDWebImageCompletionBlock)completedBlock processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock{
    [self sd_setImageWithURL:url placeholderImage:placeholder options:options progress:nil completed:completedBlock processKey:processKey processBlock:processBlock];
}


- (void)sd_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(SDWebImageOptions)options progress:(SDWebImageDownloaderProgressBlock)progressBlock completed:(SDWebImageCompletionBlock)completedBlock processKey:(NSString*)processKey processBlock:(SDWebImageProcessBlock)processBlock {
    [self sd_cancelCurrentImageLoad];
    objc_setAssociatedObject(self, &imageURLKey_Process, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!(options & SDWebImageDelayPlaceholder)) {
        dispatch_main_async_safe(^{
            self.image = placeholder;
        });
    }
    
    if (url) {
        
        // check if activityView is enabled or not
        if ([self showActivityIndicatorView]) {
            [self addActivityIndicator];
        }
        
        __weak __typeof(self)wself = self;
        id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadImageWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [wself removeActivityIndicator];
            if (!wself) return;
            dispatch_main_sync_safe(^{
                if (!wself) return;
                if (image && (options & SDWebImageAvoidAutoSetImage) && completedBlock)
                {
                    completedBlock(image, error, cacheType, url);
                    return;
                }
                else if (image) {
                    wself.image = image;
                    [wself setNeedsLayout];
                } else {
                    if ((options & SDWebImageDelayPlaceholder)) {
                        wself.image = placeholder;
                        [wself setNeedsLayout];
                    }
                }
                if (completedBlock && finished) {
                    completedBlock(image, error, cacheType, url);
                }
            });
        } processKey:processKey processBlock:processBlock];
        [self sd_setImageLoadOperation:operation forKey:@"UIImageViewImageLoad"];
    } else {
        dispatch_main_async_safe(^{
            [self removeActivityIndicator];
            if (completedBlock) {
                NSError *error = [NSError errorWithDomain:SDWebImageErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"Trying to load a nil url"}];
                completedBlock(nil, error, SDImageCacheTypeNone, url);
            }
        });
    }
}


@end
