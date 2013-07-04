//
//  Lodestone.h
//  FFXIV
//
//  Created by Florian Strauss on 03.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FFCharacter.h"

#define kFFLodestoneCharacterURLPath @"/lodestone/character/"
#define kFFLodestoneUserAgent @"Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1468.0 Safari/537.36"

typedef void(^FFLodestoneCharacterHandler)(FFCharacter *character, NSError *error);

@interface FFLodestone : NSObject

@property (nonatomic, strong) NSString *region;

+ (FFLodestone *)sharedInstance;

- (void)fetchCharacterWithId:(NSString *)characterID completionHandler:(FFLodestoneCharacterHandler)handler;

@end
