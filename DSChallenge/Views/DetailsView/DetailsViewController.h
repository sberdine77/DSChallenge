//
//  DetailsViewController.h
//  DSChallenge
//
//  Created by Sávio Berdine on 06/01/21.
//

#import <UIKit/UIKit.h>
#import "DetailsViewViewModel.h"
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property DetailsViewViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UIImageView *storeImage;
@property (weak, nonatomic) IBOutlet UILabel *storeId;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *storePhone;
@property (weak, nonatomic) IBOutlet UILabel *storeStreet;
@property (weak, nonatomic) IBOutlet UILabel *storeNumber;
@property (weak, nonatomic) IBOutlet UILabel *storeComplement;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIView *imageContainerView;
@property (weak, nonatomic) IBOutlet UIButton *mapsButton;
@property UIImagePickerController* imagePicker;
@property UIAlertController *loadingAlert;

/*Show an alert that provides the user with library or camera source for the image picker*/
-(void) showCameraOrLibraryAllert;

/*Method responsible for showing the choosed image picker source, deal with disponibility and deal with library and camera access authorizations*/
-(void) getImageFromSource: (UIImagePickerControllerSourceType) sourceType;

-(instancetype) initWithViewModel: (DetailsViewViewModel *) viewModel;

@end

NS_ASSUME_NONNULL_END
