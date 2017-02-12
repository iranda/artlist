//
//  ArticleVC.m
//  artlist
//
//  Created by Daria Daria on 2017-02-11.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import "ArticleVC.h"

@interface ArticleVC ()
@property (weak, nonatomic) IBOutlet UILabel *articleTitle;
@property (weak, nonatomic) IBOutlet UILabel *atricleDescription;

@end

@implementation ArticleVC

- (void) setArticle:(NSDictionary *)article {
    _article = article;
    [self updateUI];
}

- (void) updateUI {
    self.articleTitle.text = [self.article valueForKey:@"title"];
    self.atricleDescription.text = [self.article valueForKey:@"description"];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.view.window) [self updateUI];
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
