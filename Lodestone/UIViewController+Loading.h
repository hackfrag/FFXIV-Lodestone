//
//  UIViewController+Loading.h
//  BirthdayCalendar
//
//  Created by Florian Strauss on 24.09.12.
//  Copyright (c) 2012 Christian Janzen & Florian Strauß GbR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDProgressView;

@interface UIViewController (Loading)

- (void)loading:(BOOL)visible;
- (void)progress:(BOOL)visible;
- (DDProgressView *)progressView;
@end
