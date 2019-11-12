#import "DemoFeature.h"

@implementation DemoFeature
+ (instancetype)featureWithType:(DemoFeatureType)type
                          title:(NSString *)title
                        details:(NSString *)details {
    DemoFeature *option  = [DemoFeature new];
    option.type = type;
    option.title = title;
    option.details = details;
    return option;
}

+ (NSArray <DemoFeature *> *)defaultFeatures {
    return @[
        [DemoFeature featureWithType:DemoFeatureTypePayment title:@"Payment" details:@"with default settings"],
        [DemoFeature featureWithType:DemoFeatureTypePreAuth title:@"PreAuth" details: @"to reserve funds on a card"],
        [DemoFeature featureWithType:DemoFeatureTypeCreateCardToken title:@"Register card" details: @"to be stored for future transactions"],
        [DemoFeature featureWithType:DemoFeatureTypeCheckCard title:@"Check card" details:@"to validate a card"],
        [DemoFeature featureWithType:DemoFeatureTypeSaveCard title:@"Save card" details: @"to be stored for future transactions"],
        [DemoFeature featureWithType:DemoFeatureTypeRepeatPayment title:@"Token payment" details: @"with a stored card token"],
        [DemoFeature featureWithType:DemoFeatureTypeTokenPreAuth title:@"Token preAuth" details: @"with a stored card token"],
        [DemoFeature featureWithType:DemoFeatureTypeApplePayPayment title:@"Apple Pay payment" details: @"with a wallet card"],
        [DemoFeature featureWithType:DemoFeatureTypeApplePayPreAuth title:@"Apple Pay preAuth" details: @"with a wallet card"],
        [DemoFeature featureWithType:DemoFeatureTypePaymentMethods title: @"Payment Method" details: @"with default payment methods"],
        [DemoFeature featureWithType:DemoFeatureTypeIDEALTransaction title:@"iDEAL Transaction" details:@"for custom bank transactions"],
        [DemoFeature featureWithType:DemoFeatureTypeStandaloneApplePayButton title: @"Apple Pay Button" details: @"Standalone ApplePay Button"]
    ];
}
@end
