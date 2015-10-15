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

@interface ViewController ()

@property (nonatomic, strong)              AppDelegate    *appDelegate;
@property (nonatomic, weak)   IBOutlet     UITableView    *characterTableView;
@property (nonatomic, weak)   IBOutlet     UISearchBar    *resultsSearchBar;

@end

@implementation ViewController

#pragma mark - Interactivity Methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search Pressed");
    [_appDelegate getDataForSearch:_resultsSearchBar.text];
}

#pragma mark - Table View Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"NRIS");
    return _appDelegate.characterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"CFRAIP");
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"charCell"];
    NSDictionary *selectedResult = _appDelegate.characterArray[indexPath.row];
    cell.textLabel.text = [selectedResult objectForKey:@"trackName"];
    
    return cell;
}

- (void)gotCharacterReceived {
    NSLog(@"GCR");
    [_characterTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *destController = [segue destinationViewController];
    NSIndexPath *indexPath = [_characterTableView indexPathForSelectedRow];
    NSDictionary *selectedCharacter = _appDelegate.characterArray[indexPath.row];
    destController.selectedCharacter = selectedCharacter;
}


#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gotCharacterReceived) name:@"gotCharactersNotification" object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
