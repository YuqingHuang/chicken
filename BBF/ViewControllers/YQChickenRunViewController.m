//
//  YQChickenRunViewController.m
//  BBF
//
//  Created by Huang Yuqing on 12/25/12.
//  Copyright (c) 2012 Huang Yuqing. All rights reserved.
//

#import "YQChickenRunViewController.h"

@implementation YQChickenRunViewController {
    NSMutableArray *chicken;
    CGImageRef imageToSplit;
}


- (id)init {
    self = [super init];
    if (self) {
        chicken = [[NSMutableArray alloc] init];
        imageToSplit = [UIImage imageNamed:@"runleft.png"].CGImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i = 0; i < 16; i++) {
        [self addChickTo:chicken withIndex:i];
    }
    
    UIImageView *animatedChickenView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
  /*  [UIView animateWithDuration:0.2
    animations:^{
        animatedChickenView.alpha = 0.0;
    }
    completion:^(BOOL finished){
        [animatedChickenView removeFromSuperview];
    }];
*/
    [self setAnimationFor:animatedChickenView];
    [animatedChickenView startAnimating];
    
	[self.view addSubview:animatedChickenView];
}

- (void)setAnimationFor:(UIImageView *)animatedChickenView {
    animatedChickenView.animationImages = chicken;

    animatedChickenView.animationDuration = 0.1;
    animatedChickenView.animationRepeatCount = 0;
}

- (void)addChickTo:(NSMutableArray *)images withIndex:(int)index {
    CGImageRef partOfImageAsCG = CGImageCreateWithImageInRect(imageToSplit, CGRectMake(64*index, 0, 64, 64));
    
    UIImage *partOfImage = [UIImage imageWithCGImage:partOfImageAsCG];
    
    [images addObject:partOfImage];
}
@end
