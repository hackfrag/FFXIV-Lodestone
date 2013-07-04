//
//  UIViewController+Error.h
//  HapKit
//
//  Created by Florian Strauss on 14.03.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Error)
- (void)displayError:(NSError *)error;
- (void)displayErrorString:(NSString *)error;
- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message;
@end
