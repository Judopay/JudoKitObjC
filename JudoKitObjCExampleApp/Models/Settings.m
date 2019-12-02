#import "Settings.h"

@implementation Settings

+ (instancetype)defaultSettings {
    Settings *settings = [Settings new];
    settings.currency = @"GBP";
    settings.isAVSEnabled = YES;
    return settings;
}

@end
