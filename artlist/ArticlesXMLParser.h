//
//  ArticlesXMLParser.h
//  artlist
//
//  Created by Daria Daria on 2017-02-11.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticlesXMLParser : NSObject <NSXMLParserDelegate>
@property (nonatomic, strong) NSMutableArray *articles;

- (NSMutableArray *)articles;
@end
