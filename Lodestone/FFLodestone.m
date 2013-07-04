//
//  Lodestone.m
//  FFXIV
//
//  Created by Florian Strauss on 03.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import "FFLodestone.h"
#import "FFCharacter.h"
#import "TFHpple.h"


@interface FFLodestone()

@property (nonatomic, strong) NSDictionary *regionMapping;
@property (nonatomic, strong) AFHTTPClient *client;
@end

@implementation FFLodestone


+ (FFLodestone *)sharedInstance
{
    static FFLodestone *sharedInstance;
    
    @synchronized(self)
    {
        if (!sharedInstance)
            sharedInstance = [[FFLodestone alloc] init];
        
        return sharedInstance;
    }
}

- (id)init
{
    self = [super init];
    if (self) {
        self.region = @"de";
        
        self.regionMapping = @{@"na": @"http://na.beta.finalfantasyxiv.com", @"de": @"http://de.beta.finalfantasyxiv.com"};

        self.client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:self.regionMapping[self.region]]];
        [self.client setDefaultHeader:@"User-Agent" value:kFFLodestoneUserAgent];
        [self.client setDefaultHeader:@"Cookie" value:@"dst_touchstone=1; ldst_is_support_browser=1;"];
    }
    return self;
}

- (AFHTTPRequestOperation *)fetchCharacterWithId:(NSString *)characterID completionHandler:(FFLodestoneCharacterHandler)handler {


    NSURLRequest *request = [self.client requestWithMethod:@"GET"
                                                      path:[NSString stringWithFormat:@"%@%@", kFFLodestoneCharacterURLPath, characterID]
                                                parameters:nil];

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
   
        NSData *data = (NSData *)responseObject;
        FFCharacter *character = [FFCharacter characterWithData:data];
        handler(character, nil);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil, error);
    }];
    [operation start];
  
    return operation;
}

- (AFHTTPRequestOperation *)searchCharacterWithName:(NSString *)name worldName:(NSString *)world
                       classjob:(NSString *)classjob completionHandler:(FFLodestoneCharacterSearchHandler)handler {
    
    if(world == nil) world = @"";
    if(classjob == nil) classjob = @"";
    
    NSURLRequest *request = [self.client requestWithMethod:@"GET"
                                                      path:[NSString stringWithFormat:@"%@",kFFLodestoneCharacterURLPath, nil]
                                                parameters:@{@"q": name, @"worldname" : world, @"classjob": classjob}];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data = (NSData *)responseObject;
        
        
        NSMutableArray *result = [NSMutableArray array];
        
        TFHpple *page = [TFHpple hppleWithHTMLData:data];
        
        NSArray *characters = [page searchWithXPathQuery:@"//div[@class='table_black_border_bottom']//tr"];
        
        for (TFHppleElement *characterElement in characters) {
 
            NSData *characterData = [characterElement.raw dataUsingEncoding:NSUTF8StringEncoding];
            TFHpple *characterRow = [TFHpple hppleWithHTMLData:characterData];
            
            TFHppleElement *nameElement = [[characterRow searchWithXPathQuery:@"//a"] objectAtIndex:0];
            
            TFHppleElement *serverElement = [[characterRow searchWithXPathQuery:@"//h4/span"] objectAtIndex:0];
            NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
            NSArray *serverStringArray = [[serverElement text] componentsSeparatedByCharactersInSet:delimiters];

            TFHppleElement *thumbnailElement = [[characterRow searchWithXPathQuery:@"//div[@class='thumb_cont_black_50']/img"] objectAtIndex:0];
            
            TFHppleElement *regionElement = [[characterRow searchWithXPathQuery:@"//div[@class='player_name_area']/span"] objectAtIndex:0];
            
            FFCharacter *character = [FFCharacter new];
            character.name = nameElement.text;
            character.server = [serverStringArray objectAtIndex:1];
            character.thumbnail = [NSURL URLWithString:[thumbnailElement objectForKey:@"src"]];
            character.region = regionElement.text;
            character.identifier = [[nameElement objectForKey:@"href"] stringByReplacingOccurrencesOfString:kFFLodestoneCharacterURLPath withString:@""];
            character.identifier = [character.identifier stringByReplacingOccurrencesOfString:@"/" withString:@""];
            [result addObject:character];
        }
        
        handler(result, nil);
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        handler(nil, error);
    }];
    [operation start];
   
    return operation;
}

@end
