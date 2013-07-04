//
//  FFCharacter.h
//  FFXIV
//
//  Created by Florian Strauss on 03.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFFCharacterClassesKeyIcon @"icon"
#define kFFCharacterClassesKeyLevel @"lvl"
#define kFFCharacterClassesKeyExp @"exp"

@interface FFCharacter : NSObject

@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSString *mainLVL;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *race;
@property (nonatomic, strong) NSString *nameday;
@property (nonatomic, strong) NSString *guardian;
@property (nonatomic, strong) NSString *cityState;
@property (nonatomic, strong) NSString *grandCompany; // TODO
@property (nonatomic, strong) NSString *gcRank; // TODO
@property (nonatomic, strong) NSString *freeCompany; // TODO
@property (nonatomic, strong) NSURL *picture;
@property (nonatomic, strong) NSURL *thumbnail;
@property (nonatomic, strong) NSDictionary *stats;
@property (nonatomic, strong) NSDictionary *attributes;
@property (nonatomic, strong) NSDictionary *elements;
@property (nonatomic, strong) NSDictionary *properties;
@property (nonatomic, strong) NSDictionary *classes;


+ (id)characterWithData:(NSData *)data;

@end
