//
//  ViewController.m
//  Lodestone
//
//  Created by Florian Strauss on 03.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self loading:YES];
    [[FFLodestone sharedInstance] fetchCharacterWithId:@"1674571" completionHandler:^(FFCharacter *character, NSError *error) {
        if(error != nil) {
            [self displayError:error];
            return;
        }
        [self loading:NO];
        self.character = character;
        [self setupContent];
    }];
}

- (void)setupContent {
    self.title = self.character.name;
    self.nameLabel.text = self.character.name;
    self.serverLabel.text = self.character.server;
    
    [self.thumbnailImage setImageWithURL:self.character.thumbnail
                        placeholderImage:nil];
}


@end
