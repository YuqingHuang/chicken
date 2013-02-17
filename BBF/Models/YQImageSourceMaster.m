#import "YQImageSourceMaster.h"
#import "YQChickenView.h"


@implementation YQImageSourceMaster {
    NSArray *imagesToSplit;
    NSMutableArray *imagesAfterSplit;
}

- (id)initWithImagesToSplit:(NSArray *)aImagesArray {
    self = [super init];
    if (self) {
        imagesToSplit = aImagesArray;
        imagesAfterSplit = [[NSMutableArray alloc] init];
    }

    return self;
}

- (NSArray *)splitImages {
    NSMutableArray *aImagesArray = [[NSMutableArray alloc] init];
    for (UIImage *aImage in imagesToSplit) {
        [imagesAfterSplit addObject:[self splitOneImage:aImage fromIndex:0 toIndex:15]];
    }
    return aImagesArray;
}

- (NSArray *)splitOneImage:(UIImage *)aImage fromIndex:(int)begin toIndex:(int)end {
    NSMutableArray *aImageArray = [[NSMutableArray alloc] init];
    for (int i = begin; i <= end; i++) {
        [self addImageTo:aImageArray withIndex:i withOriginalImage:aImage];
    }
    return aImageArray;
}

- (void)addImageTo:(NSMutableArray *)images withIndex:(int)index withOriginalImage:(UIImage *)originalImage {
    CGImageRef partOfImageAsCG = CGImageCreateWithImageInRect(originalImage.CGImage, CGRectMake(widthOfChicken * index, 0, widthOfChicken, heightOfChicken));

    UIImage *partOfImage = [UIImage imageWithCGImage:partOfImageAsCG];

    [images addObject:partOfImage];
}
@end