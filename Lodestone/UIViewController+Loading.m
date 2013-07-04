//
//  UIViewController+Loading.m
//  BirthdayCalendar
//
//  Created by Florian Strauss on 24.09.12.
//  Copyright (c) 2012 Christian Janzen & Florian Strauß GbR. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "DDProgressView.h"
@implementation UIViewController (Loading)

- (UIView *)createLoadingView {
    
    UIView *loading = [[UIView alloc] init];
    loading.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    loading.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    loading.tag = 1123002;
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activity startAnimating];
    [activity sizeToFit];
    activity.center = CGPointMake(loading.center.x, loading.frame.size.height/3);
    [loading addSubview:activity];
    [self.view addSubview:loading];
    return loading;
}


- (void)loading:(BOOL)visible {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
    UIView *loadingView = [self.view viewWithTag:1123002];
    if (loadingView==nil){
        loadingView = [self createLoadingView];
    }
    
    
    if (visible)
        loadingView.hidden = NO;
    
    loadingView.alpha = visible ? 0 : 1;
    [UIView animateWithDuration:0.3
                     animations:^{
                         loadingView.alpha = visible ? 1 : 0;
                     }
                     completion: ^(BOOL  finished) {
                         if (!visible) {
                             loadingView.hidden = YES;
                             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                         }
                     }];
}

- (UIView *)createProgressView {
    
    UIView *loading = [[UIView alloc] init];
    loading.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    loading.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    loading.tag = 1123003;
    
    DDProgressView *progress = [[DDProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 100, 40)];
    progress.tag = 1123004;
    progress.center = CGPointMake(loading.center.x, loading.frame.size.height/3);
    [loading addSubview:progress];
    [self.view addSubview:loading];
    return loading;
}

- (DDProgressView *)progressView {
    DDProgressView *progressView = (DDProgressView *)[self.view viewWithTag:1123004];
    return progressView;
}

- (void)progress:(BOOL)visible {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = visible;
    UIView *loadingView = [self.view viewWithTag:1123003];
    if (loadingView==nil){
        loadingView = [self createProgressView];
    }
    
    
    if (visible)
        loadingView.hidden = NO;
    
    loadingView.alpha = visible ? 0 : 1;
    [UIView animateWithDuration:0.3
                     animations:^{
                         loadingView.alpha = visible ? 1 : 0;
                     }
                     completion: ^(BOOL  finished) {
                         if (!visible) {
                             loadingView.hidden = YES;
                             [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                         }
                     }];
}



@end
