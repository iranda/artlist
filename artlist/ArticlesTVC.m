//
//  ArticlesTVC.m
//  artlist
//
//  Created by Daria Daria on 2017-02-10.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import "ArticlesTVC.h"
#import "ArticlesXMLParser.h"
#import "ArticleVC.h"

@interface ArticlesTVC ()

@end

@implementation ArticlesTVC

#pragma mark - Articles

@synthesize articles = _articles;
- (void)setArticles:(NSMutableArray *)articles {
    _articles = articles;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (NSMutableArray *)articles {
    if (!_articles)
        _articles = [[NSMutableArray alloc] init];
    return _articles;
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
            self.articles = [parserDelegate.articles mutableCopy];
    }] resume];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Article Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *article = self.articles[indexPath.row];
    cell.textLabel.text = [article valueForKey:@"title"];
    cell.detailTextLabel.text = [article valueForKey:@"pubDate"];
    return cell;
}


#pragma mark - Segue to show article

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[UITableViewCell class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        if (indexPath) {
            if ([segue.identifier isEqualToString:@"Show article"]) {
                if ([segue.destinationViewController isKindOfClass: [ArticleVC class]]) {
                    [(ArticleVC *)segue.destinationViewController setArticle:self.articles[indexPath.row]];
                }
            }
        }
    }
}

@end
