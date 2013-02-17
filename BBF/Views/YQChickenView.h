static int const widthOfChicken = 64;
static int const heightOfChicken = 64;

@interface YQChickenView : UIView

@property NSArray *currentAction;
@property NSString *currentActionName;
@property NSString *preActionName;
@property NSString *nextActionName;

- (void)drawChickenWith:(UIImage *)chickenCGImage;
- (void)performCurrentAction;
- (void)cleanIndexOfCurrentAction;
- (void)beginRunLeft;
- (void)beginRunRight;
- (void)beginTurnRight;
- (void)beginTurnLeft;
- (void)beginJumpLeft;
- (void)beginJumpRight;

- (void)moveToNextPosition:(CGFloat)positionX;
@end

