//
//  AppDelegate.m
//  Holocron
//
//  Created by Mike Henry on 10/14/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

Reachability *hostReach;
Reachability *internetReach;
Reachability *wifiReach;
bool internetAvailable;
bool serverAvailable;


#pragma mark - Data Fetching Methods

- (void)getDataForSearch:(NSString *)searchString {
    NSLog(@"Get data");
    NSLog(@"AD Character Type: %@",_characterType);
    NSURL *fileURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/api/characters?%@q=%@",_hostName,_characterType,searchString]];
    NSLog(@"Search: %@",fileURL);
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:fileURL];
    [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
    [request setTimeoutInterval:30.0];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (([data length] > 0) && (error == nil)) {
            NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSLog(@"Got data");
            _characterArray = [(NSDictionary *) json objectForKey:@"characters"];
//            _affiliationArray = [(NSDictionary *) json objectForKey:@"affiliations"];
//            for (NSDictionary *resultsDict in _characterArray) {
//                NSLog(@"Character Name:%@",[resultsDict objectForKey:@"name"]);
//            }
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Send Character Notification");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"gotCharactersNotification" object:nil];
            });
        }
        else {
            NSLog(@"No data");
        }
    }] resume];
}


- (void)getImageFromServer:(NSString *)localFileName fromURL:(NSString *)fullFileName atIndexPath:(NSIndexPath *)indexPath {
    if (serverAvailable) {
        NSURL *fileURL = [NSURL URLWithString:fullFileName];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:fileURL];
        [request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
        [request setTimeoutInterval:30.0];
        NSURLSession *session = [NSURLSession sharedSession];
//        NSLog(@"PreSession");
        [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            NSLog(@"Length:%lu error:%@",[data length],error);
            if (([data length]> 0) && (error == nil)) {
                NSLog(@"Got Data");
                NSString *savedFilePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:localFileName];
                UIImage *imageTemp = [UIImage imageWithData:data];
                if (imageTemp != nil) {
                    [data writeToFile:savedFilePath atomically:true];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"gotImagesNotification" object:nil];
                    });
                }
            } else {
                NSLog(@"No data");
            }
        }] resume];
    } else {
        NSLog(@"Server not available");
        //TODO: notify user that server is not available
    }
}

#pragma mark - File System Methods

- (NSString *)getDocumentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *documentDirectory = paths[0];
//    NSLog(@"DocPath:%@",paths[0]);
    return documentDirectory;
}

- (BOOL)fileIsLocal:(NSString *)filename {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:filename];
    return [fileManager fileExistsAtPath:filePath];
}

#pragma mark - Network Methods

- (void)updateReachabilityStatus:(Reachability *)currReach {
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    NetworkStatus netStatus = [currReach currentReachabilityStatus];
    if (currReach == hostReach) {
        switch (netStatus) {
            case NotReachable:
//                NSLog(@"Server not reachable");
                serverAvailable = false;
                break;
            case ReachableViaWiFi:
//                NSLog(@"Server reachable via Wifi");
                serverAvailable = true;
                break;
            case ReachableViaWWAN:
//                NSLog(@"Server reachable via WAN");
                serverAvailable = true;
                break;
            default:
                break;
        }
    }
    if (currReach == internetReach) {
        switch (netStatus) {
            case NotReachable:
//                NSLog(@"Internet not reachable");
                internetAvailable = false;
                break;
            case ReachableViaWiFi:
//                NSLog(@"Internet reachable via Wifi");
                internetAvailable = true;
                break;
            case ReachableViaWWAN:
//                NSLog(@"Internet reachable via WAN");
                internetAvailable = true;
                break;
            default:
                break;
        }
    }
}

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability *currReach = [note object];
    [self updateReachabilityStatus:currReach];
}


#pragma mark - Life Cycle Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    _hostName = @"datapad.herokuapp.com";
    hostReach = [Reachability reachabilityWithHostName:_hostName];
    [hostReach startNotifier];
        [self updateReachabilityStatus:hostReach];
    
    internetReach = [Reachability reachabilityWithHostName:_hostName];
    [internetReach startNotifier];
    [self updateReachabilityStatus:internetReach];
    _characterArray = [[NSArray alloc] init];
    _characterType = @"";
    return YES;
}



#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Holocron" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Holocron.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithBool:true],NSMigratePersistentStoresAutomaticallyOption,[NSNumber numberWithBool:true],NSInferMappingModelAutomaticallyOption, nil];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
