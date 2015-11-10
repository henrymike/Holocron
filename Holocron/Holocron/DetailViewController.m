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
    [self.navigationController presentViewController:charURI animated:true completion:nil];
}

#pragma mark - Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
//    if ([_selectedCharacter objectForKey:@"image"] != [NSNull null]) {
//    _characterImage.image = [UIImage imageNamed:[_selectedCharacter objectForKey:@"image"]];
//    }
    
    if ([_selectedCharacter objectForKey:@"image"] != [NSNull null]) {
        NSString *fileNameURL = [_selectedCharacter objectForKey:@"image"];
        NSString *fileNameFull = [fileNameURL stringByReplacingOccurrencesOfString:@"/" withString:@""];
        NSLog(@"Files %@ & %@",fileNameFull,fileNameURL);
        fileNameFull = [fileNameFull stringByReplacingOccurrencesOfString:@":" withString:@""];
        _characterImage.image = [UIImage imageNamed:[[_appDelegate getDocumentsDirectory] stringByAppendingPathComponent:fileNameFull]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
