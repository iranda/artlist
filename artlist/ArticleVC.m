//
//  ArticleVC.m
//  artlist
//
//  Created by Daria Daria on 2017-02-11.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import "ArticleVC.h"
#import "ArticlesXMLParser.h"

@interface ArticleVC ()
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *atricleDescription;

@end

@implementation ArticleVC

- (void) setArticle:(NSDictionary *)article {
    _article = article;
    //[self updateUI];
}

- (NSString *) getArticleDescription {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[[self.article valueForKey:@"description"]
                                                             dataUsingEncoding:NSUTF8StringEncoding]];
    ArticlesXMLParser *parserDelegate = [[ArticlesXMLParser alloc] initWithArray: @[@"p"]
                                                                 elementStartsAt: @"p" ];
    [parser setDelegate:parserDelegate];
    [parser parse];
    if ([parserDelegate.items count])
        return [parserDelegate.items[0] valueForKey:@"p"];
    
    return nil;
}

- (void) updateUI {
    self.articleTitle.text = [self.article valueForKey:@"title"];
    self.atricleDescription.text = [self getArticleDescription];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
