//
//  ArticleCell.h
//  artlist
//
//  Created by Daria Daria on 2017-02-12.
//  Copyright © 2017 d.sirous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArticleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *data;
@property (weak, nonatomic) IBOutlet UILabel *desc;

@end
