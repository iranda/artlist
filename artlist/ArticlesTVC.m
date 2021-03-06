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
#import "ArticleCell.h"

@interface ArticlesTVC ()
@property (strong, nonatomic) UIActivityIndicatorView *spinnerAIV;
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

#pragma mark - Spinner

- (void) activateSpinner {
    self.spinnerAIV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinnerAIV.center = CGPointMake(160, 240);
    self.spinnerAIV.hidesWhenStopped = YES;
    [self.view addSubview:self.spinnerAIV];
    [self.spinnerAIV startAnimating];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void) stopSpinner {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.spinnerAIV stopAnimating];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    });
}

#pragma mark - TVC lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setEstimatedRowHeight:85.0];
    [self activateSpinner];
    [self fetchArticles];
}

- (void)fetchArticles {
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:[NSURL URLWithString:@"http://www.macleans.ca/multimedia/feed/"]];
    [req setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        ArticlesXMLParser *parserDelegate = [[ArticlesXMLParser alloc] initWithArray: @[@"title", @"pubDate", @"description", @"content:encoded"]
                                                                     elementStartsAt: @"item" ];
        [parser setDelegate:parserDelegate];

        if ([parser parse]) {
            self.articles = [parserDelegate.items mutableCopy];
            [self stopSpinner];
        }
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

- (NSString *)getDescFromSrc: (NSString *)src {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[src dataUsingEncoding:NSUTF8StringEncoding]];
    ArticlesXMLParser *parserDelegate = [[ArticlesXMLParser alloc] initWithArray: @[@"p"]
                                                                 elementStartsAt: @"p" ];
    [parser setDelegate:parserDelegate];
    [parser parse];
    if ([parserDelegate.items count])
        return [parserDelegate.items[0] valueForKey:@"p"];
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Article Cell";
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *article = self.articles[indexPath.row];
    cell.title.text = [article valueForKey:@"title"];
    cell.data.text = [article valueForKey:@"pubDate"];
    cell.desc.text = [self getDescFromSrc:[article valueForKey:@"description"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
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
