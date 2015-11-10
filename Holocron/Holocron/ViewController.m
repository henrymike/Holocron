//
//  ViewController.m
//  Holocron
//
//  Created by Mike Henry on 10/14/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "ResultsTableViewCell.h"
#import "EasterEggViewController.h"

@interface ViewController ()

@property (nonatomic, strong)              AppDelegate    *appDelegate;
@property (nonatomic, weak)   IBOutlet     UITableView    *characterTableView;
@property (nonatomic, weak)   IBOutlet     UISearchBar    *resultsSearchBar;
@property (nonatomic, weak)   IBOutlet     UITabBarItem   *jediTabBarItem;
@property (nonatomic, weak)   IBOutlet     UITabBarItem   *sithTabBarItem;
@property (nonatomic, weak)   IBOutlet     UITabBarItem   *rebelsTabBarItem;
@property (nonatomic, weak)   IBOutlet     UITabBarItem   *empireTabBarItem;


@end

@implementation ViewController

#pragma mark - Interactivity Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [_appDelegate getDataForSearch:_resultsSearchBar.text];
    [self.view endEditing:true];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if(item.tag == 0)
    {
        NSLog(@"Jedi tab selected");
        _resultsSearchBar.placeholder = [NSString stringWithFormat:@"Search for Jedi"];
        _appDelegate.characterType = @"type=jedi&";
        [_appDelegate getDataForSearch:_resultsSearchBar.text];
    }
    if (item.tag == 1) {
        NSLog(@"Sith tab selected");
//            _resultsSearchBar.placeholder = [NSString stringWithFormat:@"Search for Sith"];
            _appDelegate.characterType = @"type=sith&";
            [_appDelegate getDataForSearch:_resultsSearchBar.text];
    }
    if (item.tag == 2) {
        NSLog(@"Rebels tab selected");
        _resultsSearchBar.placeholder = [NSString stringWithFormat:@"Search for Rebels"];
        _appDelegate.characterType = @"type=rebels&";
        [_appDelegate getDataForSearch:_resultsSearchBar.text];
    }
    if (item.tag == 3) {
        NSLog(@"Empire tab selected");
        _resultsSearchBar.placeholder = [NSString stringWithFormat:@"Search for Imperials"];
        _appDelegate.characterType = @"type=imperials&";
        [_appDelegate getDataForSearch:_resultsSearchBar.text];
    }
}

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"NRIS");
    return _appDelegate.characterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"CFRAIP");
    ResultsTableViewCell *cell = (ResultsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"charCell"];
    NSDictionary *selectedResult = _appDelegate.characterArray[indexPath.row];
    cell.characterNameLabel.text = [selectedResult objectForKey:@"name"];
    
    // fetch and load images
    if ([selectedResult objectForKey:@"image"] != [NSNull null]) {
        NSString *fileNameURL = [selectedResult objectForKey:@"image"];
        NSString *fileNameFull = [fileNameURL stringByReplacingOccurrencesOfString:@"/" withString:@""];
//        NSLog(@"Files %@ & %@",fileNameFull,fileNameURL);
        fileNameFull = [fileNameFull stringByReplacingOccurrencesOfString:@":" withString:@""];
        
        if ([_appDelegate fileIsLocal:fileNameFull]) {
//            NSLog(@"Local %@",fileNameFull);
            cell.characterImageView.image = [UIImage imageNamed:[[_appDelegate getDocumentsDirectory] stringByAppendingPathComponent:fileNameFull]];
        } else {
//            NSLog(@"Not Local %@ %@",[selectedResult objectForKey:@"name"],fileNameURL);
            [_appDelegate getImageFromServer:fileNameFull fromURL:fileNameURL atIndexPath:indexPath];
        }
    }
    
    return cell;
}

- (void)gotCharacterReceived {
    NSLog(@"Received Character Notification");
    [_characterTableView reloadData];
}

- (void)gotImageReceived {
    NSLog(@"Got Image");
//    [_characterTableView reloadRowsAtIndexPaths:@[] withRowAnimation:[UITableViewRowAnimationAutomatic];
//  [_characterTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueDetail"]) {
        DetailViewController *destController = [segue destinationViewController];
        NSIndexPath *indexPath = [_characterTableView indexPathForSelectedRow];
        NSDictionary *selectedCharacter = _appDelegate.characterArray[indexPath.row];
        NSLog(@"Character Name:%@",[selectedCharacter objectForKey:@"name"]);
        destController.selectedCharacter = selectedCharacter;
    }
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotCharacterReceived) name:@"gotCharactersNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotImageReceived) name:@"gotImagesNotification" object:nil];
    
    _appDelegate.characterType = @"";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
