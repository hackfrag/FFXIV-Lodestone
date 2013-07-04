//
//  CharacterCell.h
//  Lodestone
//
//  Created by Florian Strauss on 04.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serverLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

@end
