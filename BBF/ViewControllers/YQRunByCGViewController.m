#import "YQRunByCGViewController.h"
#import "YQChickenView.h"
#import "YQImageSourceMaster.h"

@implementation YQRunByCGViewController {
    NSMutableArray *chicken;
    YQChickenView *animationView;
    CADisplayLink *displayLink;
    CGFloat xOfAnimationView;
    int _stepGap;
    NSArray *outputImages;
}

- (id)init {
    self = [super init];
    if (self) {
        chicken = [[NSMutableArray alloc] init];
        xOfAnimationView = 256;
        _stepGap = 2;
        animationView = [[YQChickenView alloc] initWithFrame:CGRectMake(xOfAnimationView, 0, widthOfChicken, heightOfChicken)];
        [self setUpDisplayLink];
    }
    return self;
}

- (void)setUpDisplayLink {
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(performAction)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    displayLink.frameInterval = 3;
}

- (void)animateView {
    [animationView performCurrentAction];

    [self updateXOfAnimationViewAndImageSource];
    animationView.frame = CGRectMake(xOfAnimationView, 0, heightOfChicken, heightOfChicken);
}

- (void)updateXOfAnimationViewAndImageSource {
    xOfAnimationView -= _stepGap;
    if (xOfAnimationView == 0) {
        _stepGap = -2;
        animationView.currentAction = outputImages[1];
    } else if(xOfAnimationView == 256) {
        _stepGap = 2;
        animationView.currentAction = outputImages[0];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpImagesFor:animationView];
    [self.view addSubview:animationView];
}

- (void)setUpImagesFor:(YQChickenView *)aView {
    YQImageSourceMaster *imageSourceMaster = [[YQImageSourceMaster alloc] initWithImagesToSplit:
            @[[UIImage imageNamed:@"runleft.png"],
            [UIImage imageNamed:@"runright.png"],
            [UIImage imageNamed:@"turn.png"]]];
    outputImages = [imageSourceMaster splitImages];
    aView.currentAction = outputImages[0];
}

@end