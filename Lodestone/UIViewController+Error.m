//
//  UIViewController+Error.m
//  HapKit
//
//  Created by Florian Strauss on 14.03.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import "UIViewController+Error.h"

@implementation UIViewController (Error)

- (void)displayError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                    message:NSLocalizedString([error localizedDescription], nil)
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Okay", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)displayErrorString:(NSString *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", nil)
                                                    message:NSLocalizedString(error, nil)
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Okay", nil)
                                          otherButtonTitles:nil];
    [alert show];
}

- (void) showAlertWithTitle:(NSString*) title message:(NSString*) message {
    
#if TARGET_OS_IPHONE
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Dismiss", @"")
                                          otherButtonTitles:nil];
    [alert show];
#elif TARGET_OS_MAC
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:NSLocalizedString(@"Dismiss", @"")];
    
    [alert setMessageText:title];
    [alert setInformativeText:message];
    [alert setAlertStyle:NSInformationalAlertStyle];
    
    [alert runModal];
    
#endif
}

@end
