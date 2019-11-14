//
//  JP3DSWebView.m
//  JudoKitObjC
//
//  Copyright (c) 2016 Alternative Payments Ltd
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "JP3DSWebView.h"
#import "NSError+Judo.h"

@implementation JP3DSWebView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    return self;
}

- (void)setupView {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.alpha = 0.0f;
}

- (NSString *)load3DSWithPayload:(NSDictionary *)payload error:(NSError **)error {

    NSCharacterSet *allowedCharSet = [NSCharacterSet characterSetWithCharactersInString:@":/=,!$&'()*+;[]@#?"].invertedSet;

    NSString *urlString = payload[@"acsUrl"];
    NSURL *url = [NSURL URLWithString:urlString];
    NSString *mdParameter = payload[@"md"];
    NSString *receiptId = payload[@"receiptId"];
    NSString *paReqString = payload[@"paReq"];
    NSString *paReqStringEscaped = [paReqString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharSet];
    NSString *termUrlString = [@"https://pay.judopay.com/iOS/Parse3DS" stringByAddingPercentEncodingWithAllowedCharacters:allowedCharSet];

    if (!url || !mdParameter || !receiptId || !paReqString || !paReqStringEscaped || !termUrlString) {
        if (error != NULL) {
            *error = [NSError judo3DSRequestFailedErrorWithUnderlyingError:nil];
        }
        return nil;
    }

    NSData *postData = [[NSString stringWithFormat:@"MD=%@&PaReq=%@&TermUrl=%@", mdParameter, paReqStringEscaped, termUrlString] dataUsingEncoding:NSUTF8StringEncoding];

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    request.HTTPMethod = @"POST";
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%li", (unsigned long)postData.length] forHTTPHeaderField:@"Content-Length"];
    request.HTTPBody = postData;

    [self loadRequest:request];

    return receiptId;
}

@end
