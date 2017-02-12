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
@property (nonatomic, strong) NSMutableDictionary *currentItem;
@property (nonatomic, strong) NSArray *managedProperties;
@property (nonatomic, strong) NSString *startItem;

@property (nonatomic, strong) NSMutableString *currentElementValue;
@property (nonatomic, assign, getter=isNeedToSaveElement) BOOL saveElement;
@end

@implementation ArticlesXMLParser

- (id) initWithArray: (NSArray *)arrayProperties elementStartsAt: (NSString *) start {
    self = [super init];
    
    if (self) {
        self.managedProperties = arrayProperties;
        self.startItem = start;
    }
    return self;
}

- (NSMutableString *)currentElementValue {
    if (!_currentElementValue)
        _currentElementValue = [[NSMutableString alloc] init];
    return _currentElementValue;
}

- (NSMutableArray *)items {
    if (!_items)
        _items = [[NSMutableArray alloc] init];
    return _items;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if( [elementName isEqualToString:self.startItem]) {
        self.currentItem = [[NSMutableDictionary alloc] init];
    }
    if ([self.managedProperties containsObject:elementName]) {
        self.saveElement = YES;
    }
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (self.isNeedToSaveElement)
        [self.currentElementValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if (self.isNeedToSaveElement) {
        [self.currentItem setValue:[self.currentElementValue mutableCopy] forKey:elementName];
    }
    if ([elementName isEqualToString:self.startItem]) {
        [self.items addObject:self.currentItem];
        self.currentItem = nil;
    }
    self.saveElement = NO;
    [self.currentElementValue setString:@""];
}

@end
