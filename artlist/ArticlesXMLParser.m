//
//  ArticlesXMLParser.m
//  artlist
//
//  Created by Daria Daria on 2017-02-11.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import "ArticlesXMLParser.h"
#import "ArticlesTVC.h"

@interface ArticlesXMLParser()
@property (nonatomic, strong) NSMutableDictionary *currentArticle;
@property (nonatomic, strong) NSArray *managedProperties;

@property (nonatomic, strong) NSMutableString *currentElementValue;
@property (nonatomic, assign, getter=isNeedToSaveElement) BOOL saveElement;
@end

@implementation ArticlesXMLParser

- (NSMutableString *)currentElementValue {
    if (!_currentElementValue)
        _currentElementValue = [[NSMutableString alloc] init];
    return _currentElementValue;
}

- (NSMutableArray *)articles {
    if (!_articles)
        _articles = [[NSMutableArray alloc] init];
    return _articles;
}

- (NSArray *)managedProperties {
    return @[ @"title",
              @"pubDate" ];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if( [elementName isEqualToString:@"item"]) {
        self.currentArticle = [[NSMutableDictionary alloc] init];
    }
    else if ([self.managedProperties containsObject:elementName]) {
        self.saveElement = YES;
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (self.isNeedToSaveElement)
        [self.currentElementValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        [self.articles addObject:self.currentArticle];
        self.currentArticle = nil;
    }
    else if (self.isNeedToSaveElement) {
        [self.currentArticle setValue:[self.currentElementValue mutableCopy] forKey:elementName];
    }
    
    self.saveElement = NO;
    [self.currentElementValue setString:@""];
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidEndDocument");
}

@end
