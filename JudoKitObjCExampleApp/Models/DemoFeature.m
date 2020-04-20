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
        [DemoFeature featureWithType:DemoFeatureTypePayment
                               title:@"Pay with card"
                             details:@"by entering card details"],
        [DemoFeature featureWithType:DemoFeatureTypePreAuth
                               title:@"PreAuth with card"
                             details:@"by entering card details"],
        [DemoFeature featureWithType:DemoFeatureTypeCreateCardToken
                               title:@"Register card"
                             details: @"to be stored for future transactions"],
        [DemoFeature featureWithType:DemoFeatureTypeCheckCard
                               title:@"Check card"
                             details:@"to validate a card"],
        [DemoFeature featureWithType:DemoFeatureTypeSaveCard
                               title:@"Save card"
                             details: @"to be stored for future transactions"],
        [DemoFeature featureWithType:DemoFeatureTypeApplePayPayment
                               title:@"Apple Pay payment"
                             details: @"with a wallet card"],
        [DemoFeature featureWithType:DemoFeatureTypeApplePayPreAuth
                               title:@"Apple Pay preAuth"
                             details: @"with a wallet card"],
        [DemoFeature featureWithType:DemoFeatureTypePaymentMethods
                               title: @"Payment Method"
                             details: @"with default payment methods"],
        [DemoFeature featureWithType:DemoFeatureTypePreAuthMethods
                               title:@"PreAuth Methods"
                             details:@"with default preauth methods"],
        [DemoFeature featureWithType:DemoFeatureTypeServerToServer
                               title:@"Server-to-Server payment methods"
                             details:@"with default Server-to-Server payment methods"],
    ];
}
@end
