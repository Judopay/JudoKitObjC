//
//  SettingsViewController.m
//  JudoKitObjCExample
//
//  Copyright (c) 2019 Alternative Payments Ltd
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

#import "SettingsViewController.h"
#import "Settings.h"

@interface SettingsViewController ()

@property (strong, nonatomic) Settings *settings;
@property (weak, nonatomic) IBOutlet UISegmentedControl *currencySegmentedControl;
@property (weak, nonatomic) IBOutlet UISwitch *avsSwitch;

@end

@implementation SettingsViewController

- (instancetype)initWithSettings:(Settings *)settings {
    if (self = [super init]) {
        self.settings = settings;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.settings) {
        self.settings = [Settings defaultSettings];
    }
    
    self.avsSwitch.on = self.settings.isAVSEnabled;
    for (int i = 0; i < self.currencySegmentedControl.numberOfSegments; i++) {
        if ([[self.currencySegmentedControl titleForSegmentAtIndex:i] isEqualToString: self.settings.currency]) {
            [self.currencySegmentedControl setSelectedSegmentIndex: i];
        }
    }
}

- (IBAction)didTapCloseButton:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        if ([weakSelf.delegate respondsToSelector:@selector(settingsViewController:didUpdateSettings:)]) {
            [weakSelf.delegate settingsViewController:weakSelf
                                    didUpdateSettings:weakSelf.settings];
        }
    }];
}

- (IBAction)didToggleAVS:(id)sender {
    self.settings.isAVSEnabled = self.avsSwitch.on;
}

- (IBAction)didChangeCurrency:(id)sender {
    NSUInteger index = self.currencySegmentedControl.selectedSegmentIndex;
    self.settings.currency = [self.currencySegmentedControl titleForSegmentAtIndex:index];
}

@end
