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
@property (weak, nonatomic) IBOutlet UIWebView *articleBody;

@end

@implementation ArticleVC

- (void) getBody {
    [self.articleBody loadHTMLString:[self.article valueForKey:@"content:encoded"]
                             baseURL: [[NSBundle mainBundle] bundleURL]];
}

- (void) updateUI {
    self.articleTitle.text = [self.article valueForKey:@"title"];
    [self getBody];
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
