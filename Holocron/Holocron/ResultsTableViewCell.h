//
//  ResultsTableViewCell.h
//  Holocron
//
//  Created by Mike Henry on 11/10/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ResultsTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *characterImageView;
@property (nonatomic, weak) IBOutlet UILabel     *characterNameLabel;



@end
