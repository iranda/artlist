//
//  ArticleVC.h
//  artlist
//
//  Created by Daria Daria on 2017-02-11.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleVC : UIViewController
@property (nonatomic, strong) NSDictionary *article;

- (void) setArticle:(NSDictionary *)article;
@end
