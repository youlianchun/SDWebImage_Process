//
//  SDWebImageManager+Process.h
//  YYKit_Demo
//
//  Created by YLCHUN on 16/12/28.
//  Copyright © 2016年 ylchun. All rights reserved.
//

#import "SDWebImageManager.h"
typedef UIImage *(^SDWebImageProcessBlock)(UIImage *image);

@interface SDWebImageManager (Process)

- (id <SDWebImageOperation>)downloadImageWithURL:(NSURL *)url
                                         options:(SDWebImageOptions)options
                                        progress:(SDWebImageDownloaderProgressBlock)progressBlock
                                       completed:(SDWebImageCompletionWithFinishedBlock)completedBlock
                                      processKey:(NSString*)processKey
                                    processBlock:(SDWebImageProcessBlock)processBlock;
@end
