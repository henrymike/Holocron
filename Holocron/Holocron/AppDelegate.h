//
//  AppDelegate.h
//  Holocron
//
//  Created by Mike Henry on 10/14/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic)            NSManagedObjectContext       *managedObjectContext;
@property (readonly, strong, nonatomic)            NSManagedObjectModel         *managedObjectModel;
@property (readonly, strong, nonatomic)            NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong)                      NSString                     *hostName;
@property (nonatomic, strong)                      NSArray                      *characterArray;
@property (nonatomic, strong)                      NSString                     *characterType;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSString *)getDocumentsDirectory;
- (BOOL)fileIsLocal:(NSString *)filename;
- (void)getDataForSearch:(NSString *)searchString;
- (void)getImageFromServer:(NSString *)localFileName fromURL:(NSString *)fullFileName atIndexPath:(NSIndexPath *)indexPath;


@end

