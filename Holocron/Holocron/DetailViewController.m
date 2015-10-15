//
//  DetailViewController.m
//  Holocron
//
//  Created by Mike Henry on 10/15/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic, strong)        AppDelegate *appDelegate;
@property (nonatomic, weak) IBOutlet UIImageView *characterImage;
@property (nonatomic, weak) IBOutlet UILabel     *characterName;
@property (nonatomic, weak) IBOutlet UILabel     *characterHomePlanet;
@property (nonatomic, weak) IBOutlet UILabel     *characterSpecies;
@property (nonatomic, weak) IBOutlet UITextView  *characterBioTextView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _characterName.text = [_selectedCharacter objectForKey:@"name"];
    _characterHomePlanet.text = [_selectedCharacter objectForKey:@"homeworld"];
    _characterSpecies.text = [_selectedCharacter objectForKey:@"species"];
    _characterBioTextView.text = [_selectedCharacter objectForKey:@"summary"];
    _characterImage.image = [UIImage imageNamed:[_selectedCharacter objectForKey:@"image"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
