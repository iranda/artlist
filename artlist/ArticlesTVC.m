//
//  ArticlesTVC.m
//  artlist
//
//  Created by Daria Daria on 2017-02-10.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import "ArticlesTVC.h"
#import "ArticlesXMLParser.h"

@interface ArticlesTVC ()

@end

@implementation ArticlesTVC

#pragma mark - Setters

- (void)setArticles:(NSString *)articles {
    _articles = articles;
    [self.tableView reloadData];
}

#pragma mark - TVC lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchArticles];
}

- (void)fetchArticles {
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:@"http://www.macleans.ca/multimedia/feed/"]];
    [req setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        ArticlesXMLParser *parserDelegate = [[ArticlesXMLParser alloc] init];
        [parser setDelegate:parserDelegate];

        if ([parser parse])
            NSLog(@"Success");

    }] resume];
    
    
    self.articles = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

@end
