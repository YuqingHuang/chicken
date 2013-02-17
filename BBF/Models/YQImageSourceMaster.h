#import <Foundation/Foundation.h>

@interface YQImageSourceMaster : NSObject

- (id)initWithImagesToSplit:(NSArray *)imagesToSplit;
- (NSArray *)splitImages;
- (NSArray *)splitOneImage:(UIImage *)aImage fromIndex:(int)begin toIndex:(int)end;

@end