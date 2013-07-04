//
//  SidePanelViewController.m
//  Lodestone
//
//  Created by Florian Strauss on 04.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import "SidePanelViewController.h"

@interface SidePanelViewController ()

@end

@implementation SidePanelViewController

- (void)awakeFromNib {
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"leftViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"centerViewController"]];

}

@end
