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
@property (nonatomic, weak) IBOutlet UIButton    *characterURIButton;

@end

@implementation DetailViewController



#pragma mark - Interactivity Methods

- (IBAction)characterURIButtonPressed:(id)sender {
    NSLog(@"URI Button Pressed URI:%@",_characterURIButton);
    SFSafariViewController *charURI = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:[_selectedCharacter objectForKey:@"external_uri"]]];
//    SFSafariViewController *charURI = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"BLAH"]];
//    SFSafariViewController *charURI = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"http://www.recode.net"]];
//    SFSafariViewController *charURI = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"%@",_characterURI]];
    [self.navigationController presentViewController:charURI animated:true completion:nil];
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    NSLog(@"Character Name:%@",[_selectedCharacter objectForKey:@"name"]);
    
    _characterHomePlanet.text = @"Home Planet Unknown";
    _characterSpecies.text = @"Species Unknown";
    _characterBioTextView.text = @"Bio Unknown";
    
    
    if ([_selectedCharacter objectForKey:@"name"] != [NSNull null]) {
    _characterName.text = [_selectedCharacter objectForKey:@"name"];
    }
    if ([_selectedCharacter objectForKey:@"homeworld"] != [NSNull null]) {
    _characterHomePlanet.text = [_selectedCharacter objectForKey:@"homeworld"];
    }
    if ([_selectedCharacter objectForKey:@"species"] != [NSNull null]) {
        _characterSpecies.text = [_selectedCharacter objectForKey:@"species"];
    }
    if ([_selectedCharacter objectForKey:@"summary"] != [NSNull null]) {
    _characterBioTextView.text = [_selectedCharacter objectForKey:@"summary"];
    }
//    if ([_selectedCharacter objectForKey:@"external_uri"] != [NSNull null]) {
//        _characterURI = [_selectedCharacter objectForKey:@"external_uri"];
//    }
    if ([_selectedCharacter objectForKey:@"image"] != [NSNull null]) {
    _characterImage.image = [UIImage imageNamed:[_selectedCharacter objectForKey:@"image"]];
    }
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
