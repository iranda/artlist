//
//  articleXmlParser.m
//  artlist
//
//  Created by Daria Daria on 2017-02-11.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import "articleXmlParser.h"

@implementation articleXmlParser

- (void) parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidStartDocument");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSLog(@"didStartElement --> %@", elementName);
}

-(void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"foundCharacters --> %@", string);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"didEndElement   --> %@", elementName);
}

- (void) parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"parserDidEndDocument");
}
@end
