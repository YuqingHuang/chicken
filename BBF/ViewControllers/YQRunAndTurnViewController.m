#import <QuartzCore/QuartzCore.h>
#import "YQRunAndTurnViewController.h"
#import "YQChickenView.h"

static int stepGap = 2;
static int const minX = 0;
static int const maxX = 254;

@implementation YQRunAndTurnViewController {
    YQChickenView *liveChicken;
    CADisplayLink *displayLink;

    CGFloat xOfAnimationView;
    int count;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setUpDisplayLink];
        [self setUpParametersRelatedToAnimation];
    }
    return self;
}

- (void)setUpParametersRelatedToAnimation {
    xOfAnimationView = maxX;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpLiveChicken];
    [self setUpGestureForTap];
    [self.view addSubview:liveChicken];
}

- (void)setUpDisplayLink {
    displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(performAction)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    displayLink.frameInterval = 3;
}

- (void)performAction {
    [liveChicken performCurrentAction];

    [self updateCurrentActionOfChicken];

    [self updatePositionX];
    [liveChicken moveToNextPosition:xOfAnimationView];

}

- (void)updateCurrentActionOfChicken {
    if ([self needToTurnLeft]) {
        [self changeDirection];
        [liveChicken beginTurnLeft];

    } else if([self needToTurnRight]) {
        [self changeDirection];
        [liveChicken beginTurnRight];
    }

    if (liveChicken.nextActionName) {
        [self afterTurning];
    }

    if (liveChicken.preActionName) {
        [self afterJumping];
    }


}

- (void)setUpLiveChicken{
    liveChicken = [[YQChickenView alloc] initWithFrame:CGRectMake(xOfAnimationView, 0, widthOfChicken, heightOfChicken)];
    [liveChicken beginRunLeft];
}

- (void)setUpGestureForTap {
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer {
    [self needToJump];
    [liveChicken performCurrentAction];
    xOfAnimationView -= stepGap;
    liveChicken.frame = CGRectMake(xOfAnimationView, 0, heightOfChicken, heightOfChicken);
}

- (void)needToJump {
    if([liveChicken.currentActionName isEqualToString:@"runleft"]) {
        [liveChicken beginJumpLeft];
    } else {
        [liveChicken beginJumpRight];
    }
    count = 10;
    [liveChicken cleanIndexOfCurrentAction];
}

- (void)updatePositionX {
    xOfAnimationView -= stepGap;
}

- (BOOL)needToTurnRight {
    return xOfAnimationView > 256;
}

- (BOOL)needToTurnLeft {
    return xOfAnimationView < minX;
}

- (void)changeDirection {
    stepGap = 0 - stepGap;
}

- (void)afterTurning {
    if ([liveChicken.currentActionName isEqualToString:@"turnleft"]) {
        [liveChicken beginRunRight];
    } else if ([liveChicken.currentActionName isEqualToString:@"turnright"]) {
        [liveChicken beginRunLeft];
    }
    [liveChicken cleanIndexOfCurrentAction];
}

- (void)afterJumping {
    if (count == 0) {
        if ([liveChicken.currentActionName isEqualToString:@"jumpleft"]) {
            [liveChicken beginRunLeft];
        }
        if ([liveChicken.currentActionName isEqualToString:@"jumpright"]) {
            [liveChicken beginRunRight];
        }
    }
    count --;
    [liveChicken cleanIndexOfCurrentAction];
}


@end