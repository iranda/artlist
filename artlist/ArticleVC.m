//
//  ArticleVC.m
//  artlist
//
//  Created by Daria Daria on 2017-02-11.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import "ArticleVC.h"

@interface ArticleVC ()

@end

@implementation ArticleVC

- (void) setArticle:(NSDictionary *)article {
    _article = article;
    [self updateUI];
}

- (void) updateUI {
    self.title = [self.article valueForKey:@"title"];
    //self.tmp.text = [self.article valueForKey:@"title"];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.view.window) [self updateUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
