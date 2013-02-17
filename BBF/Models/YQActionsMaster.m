#import "YQActionsMaster.h"
#import "YQImageSourceMaster.h"


@implementation YQActionsMaster {
    YQImageSourceMaster *imageSourceMaster;
}

static YQActionsMaster *SharedActionMaster;

-(id)init {
    self = [super init];
    if (self) {
        imageSourceMaster = [[YQImageSourceMaster alloc] init];
        _actions = [self fetchActionsWithExistingImages];
    }
    return self;
}

- (NSDictionary *)fetchActionsWithExistingImages {
    NSMutableDictionary *initialActionDictionary = [[NSMutableDictionary alloc] init];

    [initialActionDictionary setObject:[self fetchAnActionWithName:@"runleft" withIndexFrom:0 withIndexTo:15] forKey:@"runleft"];
    [initialActionDictionary setObject:[self fetchAnActionWithName:@"runright" withIndexFrom:0 withIndexTo:15] forKey:@"runright"];
    [initialActionDictionary setObject:[self fetchAnActionWithName:@"jumpleft" withIndexFrom:0 withIndexTo:11] forKey:@"jumpleft"];
    [initialActionDictionary setObject:[self fetchAnActionWithName:@"jumpright" withIndexFrom:0 withIndexTo:11] forKey:@"jumpright"];
    [initialActionDictionary setObject:[self fetchAnActionWithName:@"turn" withIndexFrom:0 withIndexTo:5] forKey:@"turnleft"];
    [initialActionDictionary setObject:[self fetchAnActionWithName:@"turn" withIndexFrom:6 withIndexTo:11] forKey:@"turnright"];
    [initialActionDictionary setObject:[self fetchAnActionWithName:@"idle2wave" withIndexFrom:0 withIndexTo:9] forKey:@"wave"];

    return initialActionDictionary;
}

- (NSArray *)fetchAnActionWithName:(NSString *)anActionName withIndexFrom:(int)from withIndexTo:(int)to {
    NSArray *anActionContent = [imageSourceMaster splitOneImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", anActionName]] fromIndex:from toIndex:to];
    return anActionContent;
}

+ (YQActionsMaster *)sharedActionMaster {
    if(!SharedActionMaster) {
        SharedActionMaster = [[YQActionsMaster alloc] init];
    }
    return SharedActionMaster;
}


@end
