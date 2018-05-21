//
//  SnowView.m
//  jinshanStrmear
//
//  Created by lalala on 16/12/12.
//  Copyright © 2016年 王森. All rights reserved.
//

#import "SnowView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface SnowView()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, strong) CAEmitterLayer *flowerLayer;//粒子发射器
@property (nonatomic, strong) UIImageView *backgroundView;
@end
@implementation SnowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
//        [self creatSnowWithViwe];
    }
    return self;
}

-(void)creatSnowWithViwe{
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handlerAction:)];
        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}
- (void)handlerAction:(CADisplayLink *)displayLink{
    UIImage *image = [UIImage imageNamed:@"1.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    CGFloat scale = arc4random_uniform(30)/100.0;
    imageView.transform = CGAffineTransformMakeScale(scale, scale);
    CGSize winSize = self.bounds.size;
    CGFloat x = arc4random_uniform(winSize.width);
    CGFloat y = - imageView.frame.size.height;
    imageView.center = CGPointMake(x, y);
    [self addSubview:imageView];
    [UIView animateWithDuration:arc4random_uniform(5) animations:^{
        CGFloat toX = arc4random_uniform(winSize.width);
        CGFloat toY = imageView.frame.size.height * 0.5 + winSize.height + 20;
        imageView.center = CGPointMake(toX, toY);
        imageView.transform = CGAffineTransformRotate(imageView.transform, arc4random_uniform(M_PI * 2));
        imageView.alpha = 1;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.displayLink invalidate];
        self.displayLink = nil;
    });
}

-(void)creatSnowWithImageName:(UIImage *)imageName showView:(UIView *)snowView{
    //雪花飘落效果
    CAEmitterLayer *flowerLayer = [CAEmitterLayer layer];
    flowerLayer.emitterPosition = CGPointMake(100, -30);
    flowerLayer.emitterSize = CGSizeMake(self.bounds.size.width * 2   , 0);
    flowerLayer.emitterMode = kCAEmitterLayerSurface;
    flowerLayer.emitterShape = kCAEmitterLayerLine;
    CAEmitterCell *flowerCell = [CAEmitterCell emitterCell];
    flowerCell.contents = (__bridge id)imageName.CGImage;
    //花瓣缩放比例
    flowerCell.scale = 0.3;
    flowerCell.scaleRange = 0.5;
    //每秒产生的花瓣数目
    flowerCell.birthRate = 15;
    flowerCell.lifetime = 100;
    //花瓣变透明的速度
    flowerCell.alphaSpeed = -0.0001;
    //秒速“五”厘米~~
    flowerCell.velocity = 240;
    flowerCell.velocityRange = 240;
    //花瓣掉落的角落范围
    flowerCell.emissionRange = M_PI;
    //花瓣旋转的速度
    flowerCell.spin = M_PI_4;
    flowerCell.spinRange = M_PI;
    //阴影的不透明度
    flowerLayer.shadowOpacity = 0;
    //阴影化开的程度
    flowerLayer.shadowRadius = 12;
    //阴影的偏移量
    _flowerLayer.shadowOffset = CGSizeMake(3, 3);
    //阴影的颜色
    _flowerLayer.shadowColor = [[UIColor whiteColor] CGColor];
    _flowerLayer.emitterCells = [NSArray arrayWithObject:flowerCell];
    [snowView.layer addSublayer:_flowerLayer];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:5 animations:^{
            snowView.alpha = 0;
        }completion:^(BOOL finished) {
            [flowerLayer removeFromSuperlayer];
            [snowView removeFromSuperview];
        }];
        
    });
}
-(void)deleteEmitCellLayer{
    [self.flowerLayer removeFromSuperlayer];
    [self.backgroundView removeFromSuperview];
}

-(void)showImage:(UIImage *)imageNmae InView:(UIView *)showView{
    
    CAEmitterLayer *flowerLayer = [CAEmitterLayer layer];
    flowerLayer.emitterPosition = CGPointMake(250, -40);
    flowerLayer.emitterSize = CGSizeMake(self.bounds.size.width * 2   , 0);
    flowerLayer.emitterMode = kCAEmitterLayerSurface;
    flowerLayer.emitterShape = kCAEmitterLayerLine;
    //flowerLayer.masksToBounds = YES;
    [showView.layer addSublayer:flowerLayer];
    //showView.layer.masksToBounds = YES;
    
    CAEmitterCell * snowFlake = [CAEmitterCell emitterCell];
    snowFlake.birthRate = 1.1f;
    snowFlake.speed = 20.f;
    //花瓣变透明的速度
    snowFlake.alphaSpeed = -0.0001;
    snowFlake.velocity = 30.f;
    snowFlake.velocityRange = 20.f;
    snowFlake.yAcceleration = 10.f;
    //花瓣掉落的角落范围
    snowFlake.emissionRange = M_PI;
    
    snowFlake.spin = M_PI_4;
    snowFlake.spinRange = M_PI;
    snowFlake.contents = (__bridge id)imageNmae.CGImage;
    snowFlake.lifetime = 300.f;
    snowFlake.scale = 0.3;
    snowFlake.scaleRange = 0.2;
//    //阴影的不透明度
//    emitterLayer.shadowOpacity = 0;
//    //阴影化开的程度
//    emitterLayer.shadowRadius = 12;
//    //阴影的偏移量
//    emitterLayer.shadowOffset = CGSizeMake(3, 3);
//    //阴影的颜色
//    emitterLayer.shadowColor = [[UIColor whiteColor] CGColor];
    
    flowerLayer.emitterCells = @[snowFlake];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:2 animations:^{
//            showView.alpha = 0;
//        }completion:^(BOOL finished) {
//            [flowerLayer removeFromSuperlayer];
//            [showView removeFromSuperview];
//        }];
//
//    });
}
-(void)showGoldCoinsImage:(UIImage *)imageName inView:(UIView *)showsView{
    CAEmitterLayer *coinsLayer = [CAEmitterLayer layer];
    coinsLayer.emitterPosition = CGPointMake(150, -40);
    coinsLayer.emitterSize = CGSizeMake(SCREEN_WIDTH, 0);
    coinsLayer.emitterMode = kCAEmitterLayerOutline;
    coinsLayer.emitterShape = kCAEmitterLayerLine;
    [showsView.layer addSublayer:coinsLayer];
    
    CAEmitterCell *coinsCell = [CAEmitterCell emitterCell];
    coinsCell.birthRate = 0.1f;
    coinsCell.speed = 50.f;
    coinsCell.alphaSpeed = 0;
    coinsCell.velocity = -500.f;
    coinsCell.velocityRange = 5.f;
    coinsCell.yAcceleration = 100.f;
    coinsCell.emissionRange = 0;
    
    coinsCell.contents = (__bridge id)imageName.CGImage;
    coinsCell.lifetime = 300.f;
    coinsCell.scale = 0.4;
    coinsCell.scaleRange = 0.2;
    
    coinsLayer.emitterCells = @[coinsCell];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:2 animations:^{
            
        } completion:^(BOOL finished) {
            [coinsLayer removeFromSuperlayer];
        }];
    });
    
}


@end
