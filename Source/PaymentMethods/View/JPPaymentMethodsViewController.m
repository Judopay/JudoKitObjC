//
//  JPPaymentMethodsViewController.m
//  JudoKitObjC
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

#import "JPPaymentMethodsViewController.h"
#import "JPPaymentMethodsView.h"
#import "JPPaymentMethodsViewModel.h"
#import "JPPaymentMethodSelectionCell.h"
#import "JPPaymentMethodsPresenter.h"
#import "CardPreviewView.h"
#import "CardPreviewViewModel.h"


@interface JPPaymentMethodsViewController()

@property (nonatomic, strong) JPPaymentMethodsView *paymentMethodsView;
@property (nonatomic, strong) JPPaymentMethodsViewModel *viewModel;
@property (nonatomic, strong) CardPreviewView *cardPreviewView;

@end

@implementation JPPaymentMethodsViewController

//------------------------------------------------------------------------
#pragma mark - View lifecycle
//------------------------------------------------------------------------

- (void)loadView {
    self.paymentMethodsView = [JPPaymentMethodsView new];
    self.view = self.paymentMethodsView;
    [self configureView];
    [self.presenter prepareInitialViewModel];
}

//------------------------------------------------------------------------
#pragma mark - Layout setup
//------------------------------------------------------------------------

- (void)configureView {
    self.paymentMethodsView.tableView.delegate = self;
    self.paymentMethodsView.tableView.dataSource = self;
}

//------------------------------------------------------------------------
#pragma mark - JPPaymentMethodsView protocol conformance
//------------------------------------------------------------------------

- (void)configureWithViewModel:(JPPaymentMethodsViewModel *)viewModel {
    self.viewModel = viewModel;
    
    for (JPPaymentMethodsModel *item in viewModel.items) {
        [self.paymentMethodsView.tableView registerClass:NSClassFromString(item.identifier)
                                  forCellReuseIdentifier:item.identifier];
    }
    
    [self.paymentMethodsView.tableView reloadData];
}

@end

@implementation JPPaymentMethodsViewController (TableViewDelegates)

//------------------------------------------------------------------------
#pragma mark - UITableView Data Source
//------------------------------------------------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"testCell"];
    cell.textLabel.text =@"Test payemnt Method";
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        JPAmount *amount = [[JPAmount alloc]initWithAmount:@"421" currency:@"$"];
        JPPaymentMethodsCardModel *cardModel = [[JPPaymentMethodsCardModel alloc] init];
        cardModel.cardNetwork = CardNetworkElo;
        cardModel.cardNumberLastFour = @"5200";
        cardModel.cardTitle = @"NOT SO BEST CARD";
        cardModel.isDefaultCard = YES;
        cardModel.expiryDate = @"04/22";
        CardPreviewViewModel *cardPreviewViewModel = [[CardPreviewViewModel alloc] initWithAmount:amount
                                                                                        cardModel:cardModel
                                                                                  payButtonTitlte:@"PAY NOW"
                                                                                 payButtonHandler:@selector(PAYFUNC)];
        
        
        [self.cardPreviewView changePaymentMethodPreview:cardPreviewViewModel animtionType:AnimateBottomToTop];
    } else {
        JPAmount *amount = [[JPAmount alloc]initWithAmount:@"422" currency:@"$"];
        JPPaymentMethodsCardModel *cardModel = [[JPPaymentMethodsCardModel alloc] init];
        cardModel.cardNetwork = CardNetworkElo;
        cardModel.cardNumberLastFour = @"56200";
        cardModel.cardTitle = @"THE Second Best CARD";
        cardModel.isDefaultCard = YES;
        cardModel.expiryDate = @"04/21";
        
        CardPreviewViewModel *cardPreviewViewModel = [[CardPreviewViewModel alloc] initWithAmount:amount
                                                                                        cardModel:cardModel
                                                                                  payButtonTitlte:@"PAY NOW"
                                                                                 payButtonHandler:@selector(PAYFUNC)];
        
        [self.cardPreviewView changePaymentMethodPreview:cardPreviewViewModel animtionType:AnimateRightToLeft];
    }
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    self.cardPreviewView.layer.zPosition = -1;
    return self.cardPreviewView;
}

//------------------------------------------------------------------------
#pragma mark - UITableView Delegate
//------------------------------------------------------------------------

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 312.0f;
}


-(CardPreviewView *)cardPreviewView{
    if(!_cardPreviewView) {
        JPAmount *amount = [[JPAmount alloc]initWithAmount:@"420" currency:@"$"];
       
        CardPreviewViewModel *cardPreviewViewModel = [[CardPreviewViewModel alloc] initWithAmount:amount
                                                                                        cardModel:nil
                                                                                  payButtonTitlte:@"PAY NOW"
                                                                                 payButtonHandler:@selector(PAYFUNC)];
        _cardPreviewView = [[CardPreviewView alloc]initWithViewModel:cardPreviewViewModel];
    }
    return _cardPreviewView;
}

- (void)PAYFUNC{
    NSLog(@"PAY");
}
@end


