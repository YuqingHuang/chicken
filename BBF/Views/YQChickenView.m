#import "YQChickenView.h"
#import "YQActionsMaster.h"

@implementation YQChickenView {
    int index;
    NSDictionary *chickenActions;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        index = 0;
        chickenActions = [[YQActionsMaster sharedActionMaster] actions];
    }
    return self;
}

- (void)performCurrentAction {
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self cleanChicken];
    [self drawChickenWith:_currentAction[index]];

    [self updateIndexOfCurrentAction];
}

- (void)drawChickenWith:(UIImage *)chickenImage {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, widthOfChicken);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGRectMake(0, 0, widthOfChicken, heightOfChicken), chickenImage.CGImage);
}

- (void)updateIndexOfCurrentAction {
    if (++index >= (_currentAction.count - 1)) {
        [self cleanIndexOfCurrentAction];
    }
}

- (void)cleanChicken {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, CGRectMake(0, 0, widthOfChicken, heightOfChicken));
}

- (void)cleanIndexOfCurrentAction {
    index = 0;
}



#pragma Actions
- (void)beginRunLeft {
    [self cleanPreAndNextAction];
    _currentAction = chickenActions[@"runleft"];
    _currentActionName = @"runleft";
}

- (void)beginRunRight {
    [self cleanPreAndNextAction];
    _currentAction = chickenActions[@"runright"];
    _currentActionName = @"runright";
}

- (void)cleanPreAndNextAction {
    _preActionName = nil;
    _nextActionName = nil;
}

- (void)beginTurnRight {
    [self cleanPreAndNextAction];
    _currentAction = chickenActions[@"turnright"];
    _currentActionName = @"turnright";
    _nextActionName = @"runleft";
}

- (void)beginTurnLeft {
    [self cleanPreAndNextAction];
    _currentAction = chickenActions[@"turnleft"];
    _currentActionName = @"turnleft";
    _nextActionName = @"runright";
}

- (void)beginJumpLeft {
    [self cleanPreAndNextAction];
    _preActionName = _currentActionName;
    _currentAction = chickenActions[@"jumpleft"];
    _currentActionName = @"jumpleft";
}

- (void)beginJumpRight {
    [self cleanPreAndNextAction];
    _preActionName = _currentActionName;
    _currentAction = chickenActions[@"jumpright"];
    _currentActionName = @"jumpright";
}

- (void)moveToNextPosition:(CGFloat)positionX {
    self.frame = CGRectMake(positionX, 0, heightOfChicken, heightOfChicken);
}

- (IBAction)buttonPress:(id)sender {
    NSString *paramURLAsString = @"http://www.baidu.com/";
    if ([paramURLAsString length] == 0) {
        NSLog(@"Nil or empty URL is given");
        return;
    }

    NSURLCache *urlCache = [NSURLCache sharedURLCache];    /* 设置缓存的大小为1M*/
    [urlCache setMemoryCapacity:1 * 1024 * 1024];     //创建一个nsurl
    NSURL *url = [NSURL URLWithString:paramURLAsString];        //创建一个请求
    NSMutableURLRequest *request =    [NSMutableURLRequest     requestWithURL:url     cachePolicy:NSURLRequestUseProtocolCachePolicy     timeoutInterval:60.0f];     //从请求中获取缓存输出
    NSCachedURLResponse *response =    [urlCache cachedResponseForRequest:request];    //判断是否有缓存
    if (response != nil){
        NSLog(@"如果有缓存输出，从缓存中获取数据");
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    self.connection = nil;    /* 创建NSURLConnection*/
    NSURLConnection *newConnection =    [[NSURLConnection alloc] initWithRequest:request                                    delegate:self                            startImmediately:YES];
    self.connection = newConnection;
    [newConnection release];
}
    @end