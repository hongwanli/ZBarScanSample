//
//  ViewController.m
//  ZBarScanSample
//
//  Created by neolix on 14-8-12.
//  Copyright (c) 2014年 Neolix. All rights reserved.
//

#import "ViewController.h"
#import "ZBarSDK.h"
@interface ViewController ()<ZBarReaderViewDelegate>{
    ZBarCameraSimulator * cameraSim;
}
@property (weak, nonatomic) IBOutlet ZBarReaderView *readerView;

@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end

@implementation ViewController

- (void) viewDidAppear: (BOOL) animated
{
    // run the reader when the view is visible
    [_readerView start];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if(TARGET_IPHONE_SIMULATOR) {
        cameraSim = [[ZBarCameraSimulator alloc]
                     initWithViewController: self];
        cameraSim.readerView = _readerView;
    }else{
        _readerView.readerDelegate = self;
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_readerView stop];
    [self cleanup];
}

- (void)cleanup{
    _readerView.readerDelegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- ZBarReaderViewDelegate
- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image{
    for(ZBarSymbol *sym in symbols) {
        _resultLabel.text = sym.data;
        break;
    }
}

- (BOOL)shouldAutorotate{
    return YES;
}

@end
