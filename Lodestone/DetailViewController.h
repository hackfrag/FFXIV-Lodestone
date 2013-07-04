//
//  ViewController.h
//  Lodestone
//
//  Created by Florian Strauss on 03.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFLodestone.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) FFCharacter *character;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serverLabel;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

@end
