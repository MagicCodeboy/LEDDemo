//
//  SnowView.h
//  jinshanStrmear
//
//  Created by lalala on 16/12/12.
//  Copyright © 2016年 王森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SnowView : UIView
-(void)showImage:(UIImage *)imageNmae InView:(UIView *)showView;
-(void)creatSnowWithImageName:(UIImage *)imageName showView:(UIView *)snowView;
-(void)showGoldCoinsImage:(UIImage *)imageName inView:(UIView *)showsView;
-(void)deleteEmitCellLayer;
@end
