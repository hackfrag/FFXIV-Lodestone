//
//  FFCharacter.m
//  FFXIV
//
//  Created by Florian Strauss on 03.07.13.
//  Copyright (c) 2013 Orlyapps Janzen & Strauß GbR. All rights reserved.
//

#import "FFCharacter.h"
#import "TFHpple.h"

@interface FFCharacter()


@end

@implementation FFCharacter


+ (id)characterWithData:(NSData *)data {
    
    FFCharacter *character = [FFCharacter new];
    
    TFHpple *page = [TFHpple hppleWithHTMLData:data];
    
    TFHppleElement *nameElement = [[page searchWithXPathQuery:@"//h2[@class='player_name_brown']"] objectAtIndex:0];
    character.name = [nameElement text];
    DLog(@"name %@", character.name);
    
    TFHppleElement *serverElement = [[page searchWithXPathQuery:@"//h2[@class='player_name_brown']/span"] objectAtIndex:0];
    
    NSCharacterSet *delimiters = [NSCharacterSet characterSetWithCharactersInString:@"()"];
    NSArray *splitString = [[serverElement text] componentsSeparatedByCharactersInSet:delimiters];
    character.server = [splitString objectAtIndex:1];
    DLog(@"server %@", character.server);
    
    
    // Stats
    NSMutableDictionary *stats = [NSMutableDictionary dictionary];
    NSArray *statsElements = [page searchWithXPathQuery:@"//ul[@id='power_gauge']/li"];
    for (TFHppleElement *statsElement in statsElements) {
        [stats setObject:[statsElement text] forKey:[statsElement objectForKey:@"class"]];
    }
    DLog(@"stats %@", stats);
    character.stats = [NSDictionary dictionaryWithDictionary:stats];
  
    // Attributes
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    NSArray *attributesElements = [page searchWithXPathQuery:@"//ul[@class='param_list_attributes']/li"];
    for (TFHppleElement *attributeElement in attributesElements) {
        [attributes setObject:[attributeElement text] forKey:[attributeElement objectForKey:@"class"]];
    }
    DLog(@"attributes %@", attributes);
    character.attributes = [NSDictionary dictionaryWithDictionary:attributes];
    
    
    // Elements
    NSMutableDictionary *elements = [NSMutableDictionary dictionary];
    NSArray *elementsElements = [page searchWithXPathQuery:@"//ul[@class='param_list_elemental']/li"];
    for (TFHppleElement *elementElement in elementsElements) {
        TFHppleElement *valueOfElement = [[elementElement childrenWithTagName:@"span"] objectAtIndex:0];
        [elements setObject:[valueOfElement text] forKey:[[elementElement objectForKey:@"class"]
                                                          stringByReplacingOccurrencesOfString:@"clearfix" withString:@""]];
    }
    DLog(@"elements %@", elements);
    character.elements = [NSDictionary dictionaryWithDictionary:elements];
    
    // Properties
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    NSArray *propertiesElements = [page searchWithXPathQuery:@"//ul[@class='param_list']/li"];
    for (TFHppleElement *propertieElement in propertiesElements) {
        TFHppleElement *valueOfElement = [[propertieElement childrenWithClassName:@"right"] objectAtIndex:0];
        TFHppleElement *keyOfElement = [[propertieElement childrenWithClassName:@"left"] objectAtIndex:0];
        [properties setObject:[valueOfElement text] forKey:[keyOfElement text]];
    }
    DLog(@"properties %@", properties);
    character.properties = [NSDictionary dictionaryWithDictionary:properties];

    // Classes
    
    
    NSMutableDictionary *classes = [NSMutableDictionary dictionary];
    NSArray *classesElements = [page searchWithXPathQuery:@"//table[@class='class_list']/tr"];
    for (TFHppleElement *classElement in classesElements) {
        
        TFHppleElement *keyOfElement = [[classElement childrenWithTagName:@"td"] objectAtIndex:0];
        
        TFHppleElement *iconElement = [[[[classElement childrenWithTagName:@"td"] objectAtIndex:0] childrenWithTagName:@"img"] objectAtIndex:0];
        TFHppleElement *lvlElement = [[classElement childrenWithTagName:@"td"] objectAtIndex:1];
        TFHppleElement *expElement = [[classElement childrenWithTagName:@"td"] objectAtIndex:2];
        

        
        [classes setObject:@{kFFCharacterClassesKeyIcon: [iconElement objectForKey:@"src"],
                                kFFCharacterClassesKeyLevel: lvlElement.text,
                                kFFCharacterClassesKeyExp: expElement.text} forKey:[keyOfElement text]];
    }
    DLog(@"classes %@", classes);
    character.classes = [NSDictionary dictionaryWithDictionary:classes];
    

    TFHppleElement *lvlElement = [[page searchWithXPathQuery:@"//div[@id='class_info']/div[@class='level']"] objectAtIndex:0];
    character.mainLVL = [lvlElement text];
    DLog(@"mainLVL %@", character.mainLVL);
    

    TFHppleElement *raceElement = [[page searchWithXPathQuery:@"//div[@class='chara_profile_title']"] objectAtIndex:0];
    character.race = [raceElement text];
    DLog(@"race %@", character.race);
    
    TFHppleElement *namedayElement = [[page searchWithXPathQuery:@"//ul[starts-with(@class,'chara_profile_list')]//strong"] objectAtIndex:0];
    character.nameday = [namedayElement text];
    DLog(@"nameday %@", character.nameday);
    
    TFHppleElement *guardianElement = [[page searchWithXPathQuery:@"//ul[starts-with(@class,'chara_profile_list')]//strong"] objectAtIndex:1];
    character.guardian = [guardianElement text];
    DLog(@"guardian %@", character.guardian);
    
    TFHppleElement *cityStateElement = [[page searchWithXPathQuery:@"//ul[starts-with(@class,'chara_profile_list')]//strong"] objectAtIndex:2];
    character.cityState = [cityStateElement text];
    DLog(@"cityState %@", character.cityState);
    
    TFHppleElement *pictureElement = [[page searchWithXPathQuery:@"//div[@id='chara_img_area']/div[starts-with(@class,'img_area')]/img"] objectAtIndex:0];
    character.picture = [NSURL URLWithString:[pictureElement objectForKey:@"src"]];
    DLog(@"picture %@", character.picture);
    
    TFHppleElement *thumbnailElement = [[page searchWithXPathQuery:@"//div[starts-with(@class,'area_footer')]/div[starts-with(@class,'thumb_cont_black_40')]/img"] objectAtIndex:0];
    character.thumbnail = [NSURL URLWithString:[thumbnailElement objectForKey:@"src"]];
    DLog(@"thumbnail %@", character.thumbnail);
    
    
    return character;
}


@end
