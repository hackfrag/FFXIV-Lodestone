//
//  SearchViewController.h
//  Lodestone
//
//  Created by Florian Strauss on 04.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UITableViewController <UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
