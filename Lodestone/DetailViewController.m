//
//  ViewController.m
//  Lodestone
//
//  Created by Florian Strauss on 03.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    

}
- (void)setCharacter:(FFCharacter *)character {
   
    
    [self loading:YES];
    [[FFLodestone sharedInstance] fetchCharacterWithId:character.identifier completionHandler:^(FFCharacter *character, NSError *error) {
        
        if(error != nil) {
            [self displayError:error];
            return;
        }
        
        [self loading:NO];
        _character = character;
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
