#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, DemoFeatureType) {
    DemoFeatureTypePayment,
    DemoFeatureTypePreAuth,
    DemoFeatureTypeCreateCardToken,
    DemoFeatureTypeSaveCard,
    DemoFeatureTypeCheckCard,
    DemoFeatureTypeRepeatPayment,
    DemoFeatureTypeTokenPreAuth,
    DemoFeatureTypeApplePayPayment,
    DemoFeatureTypeApplePayPreAuth,
    DemoFeatureTypePaymentMethods,
    DemoFeatureTypePreAuthMethods,
    DemoFeatureTypeIDEALTransaction,
    DemoFeatureTypeStandaloneApplePayButton
};

@interface DemoFeature : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, assign) DemoFeatureType type;

+ (instancetype)featureWithType:(DemoFeatureType)type
                          title:(NSString *)title
                        details:(NSString *)details;

+ (NSArray <DemoFeature *> *)defaultFeatures;

@end

NS_ASSUME_NONNULL_END
