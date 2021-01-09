//
//  DetailsViewViewModel.m
//  DSChallenge
//
//  Created by Sávio Berdine on 06/01/21.
//

#import "DetailsViewViewModel.h"
#import "AppDelegate.h"

@interface DetailsViewViewModel()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation DetailsViewViewModel

-(instancetype)initWith: (Store *) store {
    self = [super init];
    if (self) {
        self.store = store;
    }
    return self;
}

-(void) saveStoreImage {
    
    //Convert UIImage to JPEG representation mantaining quality
    NSData *imageData = UIImageJPEGRepresentation(self.store.image, 1);
    
    //Core Data managed object and context setup
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [[appDelegate persistentContainer] viewContext];
    
    //Fetch request setup. It is necessary to fetch from an existing image linked to the storeId, because if this is an image update, we need to override the existing image on local memory
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"StoreImages"];
    NSSortDescriptor *sortDescripotr = [NSSortDescriptor sortDescriptorWithKey:@"storeId" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescripotr]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"storeId == %@", self.store.storeId]];
    
    //Executing fetch request
    NSError *error = nil;
    NSArray *results = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    if (error != nil) {
        NSLog(@"Error fetching image: %@", error);
    }
    //If one image exists on local memory, override it with the JPEG image data
    else if (results.count > 0) {
        NSManagedObject *imageToBeUpdated = [results objectAtIndex:0];
        [imageToBeUpdated setValue:imageData forKey:@"storeImage"];
        NSError *error1 = nil;
        [self.managedObjectContext save:&error1];
        if (error != nil) {
            NSLog(@"Error saving image: %@", error1);
        }
    }
    //If no image exists on local memory, save the JPEG image data
    else {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"StoreImages" inManagedObjectContext:self.managedObjectContext];
        NSManagedObject *newStoreImage = [[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:self.managedObjectContext];
        
        [newStoreImage setValue:self.store.storeId forKey:@"storeId"];
        [newStoreImage setValue:imageData forKey:@"storeImage"];
        
        NSError *error2 = nil;
        [self.managedObjectContext save:&error2];
        if (error != nil) {
            NSLog(@"Error saving image: %@", error2);
        }
    }
    
}

-(UIImage *) fetchStoreImage {
    //Core Data managed object and context setup
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [[appDelegate persistentContainer] viewContext];
    
    //Fetch request setup
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"StoreImages"];
    NSSortDescriptor *sortDescripotr = [NSSortDescriptor sortDescriptorWithKey:@"storeId" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescripotr]];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"storeId == %@", self.store.storeId]];
    
    //Executing fetch request
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (error != nil) {
        NSLog(@"Error fetching image: %@", error);
        return [UIImage imageNamed:@"letter_L"];
    } else if (results.count == 0) {
        NSLog(@"There is no image for this store on database");
        return [UIImage imageNamed:@"letter_L"];
    } else {
        NSLog(@"Success fetching image");
        NSManagedObject *storeImage = (NSManagedObject *) [results objectAtIndex:0];
        UIImage *imageToReturn = [[UIImage alloc] initWithData:[storeImage valueForKey:@"storeImage"]];
        return imageToReturn;
    }
}

@end
