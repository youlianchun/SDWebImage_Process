//
//  ViewController.m
//  SDWebImage_Process
//
//  Created by YLCHUN on 2017/3/17.
//  Copyright © 2017年 ylchun. All rights reserved.
//

#import "ViewController.h"
#import "SDWebImage+Process.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __weak typeof(self) wself = self;
    
    NSURL *url = [NSURL URLWithString:@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"];
    
    [self.imageView sd_setImageWithURL:url processKey:@"100,50_200*300" processBlock:^UIImage *(UIImage *image) {
        //image处理,更改处理方式需要更换processKey或者清空缓存 才能看到效果
        return [wself getSubImage:image rect:CGRectMake(100, 50, 200, 300)];
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(UIImage*)getSubImage:(UIImage*)image rect:(CGRect)rect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
