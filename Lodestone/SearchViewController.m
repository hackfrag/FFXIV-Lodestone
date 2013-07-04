//
//  SearchViewController.m
//  Lodestone
//
//  Created by Florian Strauss on 04.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailViewController.h"

#import "CharacterCell.h"
#import "FFLodestone.h"

@interface SearchViewController ()

@property (strong, nonatomic)  NSArray *characters;
@property (strong, nonatomic)  AFHTTPRequestOperation *operation;


@end

@implementation SearchViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.characters = [NSArray array];
    
    self.clearsSelectionOnViewWillAppear = NO;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [self.characters count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CharacterCell";
    CharacterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    FFCharacter *character = [self.characters objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = character.name;
    cell.serverLabel.text = character.server;
    [cell.thumbnailImage setImageWithURL:character.thumbnail
                        placeholderImage:nil];
    
    return cell;
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *path = [self.tableView indexPathForSelectedRow];
    FFCharacter *character = [self.characters objectAtIndex:path.row];

    [segue.destinationViewController setCharacter:character];
}


#pragma mark - UISearchBar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    // Stop old operation
    if(self.operation != nil) {
        [self.operation cancel];
    }
    self.operation = [[FFLodestone sharedInstance] searchCharacterWithName:searchText worldName:nil classjob:nil completionHandler:^(NSArray *characters, NSError *error) {
        self.characters = characters;
        [self.tableView reloadData];
    }];
}


@end
