//
//  Lodestone.m
//  FFXIV
//
//  Created by Florian Strauss on 03.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import "FFLodestone.h"
#import "FFCharacter.h"


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

- (void)fetchCharacterWithId:(NSString *)characterID completionHandler:(FFLodestoneCharacterHandler)handler {


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
  
}

@end
