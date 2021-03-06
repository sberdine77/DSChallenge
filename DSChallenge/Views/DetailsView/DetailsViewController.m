//
//  DetailsViewController.m
//  DSChallenge
//
//  Created by Sávio Berdine on 06/01/21.
//

#import "DetailsViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface DetailsViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@end

@implementation DetailsViewController

-(instancetype) initWithViewModel: (DetailsViewViewModel *) viewModel {
    self = [super initWithNibName:@"DetailsView" bundle: [NSBundle mainBundle]];
        if (!self) {
            return nil;
        }
        self.viewModel = viewModel;
        return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //Interface setup
    self.navigationController.navigationBar.prefersLargeTitles = NO;
//    self.storeImage.layer.borderWidth = 1;
//    self.storeImage.layer.cornerRadius = 5;
    
    self.imageContainerView.clipsToBounds = false;
    self.imageContainerView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.imageContainerView.layer.shadowOpacity = 0.5;
    self.imageContainerView.layer.shadowOffset = CGSizeMake(0, 5);
    self.imageContainerView.layer.shadowRadius = 5;
    self.imageContainerView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.imageContainerView.bounds cornerRadius:10].CGPath;
    
    self.editButton.layer.cornerRadius = 5;
    
    //Image picker setup
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.delegate = self;
    
    //Filling the fields on the view
    self.storeId.text = [NSString stringWithFormat:@"Id: %@", _viewModel.store.storeId];
    self.storeName.text = _viewModel.store.name;
    self.storePhone.text = _viewModel.store.phone;
    self.storeStreet.text = _viewModel.store.address.street;
    self.storeNumber.text = _viewModel.store.address.number;
    self.storeComplement.text = _viewModel.store.address.complement;
    self.storeNeighborhood.text = _viewModel.store.address.neighborhood;
    @weakify(self);
    [RACObserve(self.viewModel, store.image) subscribeNext:^(UIImage* x) {
        @strongify(self);
        if (x != nil) {
            self.storeImage.image = x;
        }
    }];
    
    [_viewModel fetchStoreImage];
    
    //Add gesture recognizer leting the Imageview be able to call the image picker
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCameraOrLibraryAllert)];
    singleTap.numberOfTapsRequired = 1;
    [self.storeImage setUserInteractionEnabled:YES];
    [self.storeImage addGestureRecognizer:singleTap];
}

-(void) showCameraOrLibraryAllert {
    //Seting up the alert that gives the user liberty to choose between camera or library image picker sources
    UIAlertController *pickerAlert = [UIAlertController alertControllerWithTitle:@"Editar foto" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [pickerAlert addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getImageFromSource:UIImagePickerControllerSourceTypeCamera];
    }]];
    [pickerAlert addAction:[UIAlertAction actionWithTitle:@"Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self getImageFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
    }]];
    [pickerAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
    [pickerAlert setModalPresentationStyle:UIModalPresentationPopover];
    
    //Turning the alert compatible with iPad Apple standards
    UIPopoverPresentationController *popPresenter = [pickerAlert popoverPresentationController];
    popPresenter.sourceView = self.storeImage;
    popPresenter.sourceRect = self.storeImage.bounds;
    
    //Presenting the alert
    [self presentViewController:pickerAlert animated:YES completion:nil];
}

-(void) getImageFromSource: (UIImagePickerControllerSourceType) sourceType{
    //Checking if the image picker source is avalieble.
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        //If it is not determined if the user give the app permission to access this image source, ask for permission
        if(status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                //If the app has permission to access this image souce, call the image picker with this image source type
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.imagePicker.sourceType = sourceType;
                    self.imagePicker.delegate = self;
                    [self presentViewController:self.imagePicker animated:true completion:nil];
                });
            }];
        }
        //If the app has permission to access this image souce, call the image picker with this image source type
        else if (status == PHAuthorizationStatusAuthorized) {
            self.imagePicker.sourceType = sourceType;
            self.imagePicker.delegate = self;
            [self presentViewController:self.imagePicker animated:true completion:nil];
        }
        //If the user have previously denied permission to the app to access this image source, ask for permission again
        else if (status == PHAuthorizationStatusDenied) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                //If the app has permission to access this image souce, call the image picker with this image source type
                self.imagePicker.sourceType = sourceType;
                self.imagePicker.delegate = self;
                [self presentViewController:self.imagePicker animated:true completion:nil];
            }];
        }
    }
    //If the image picker source is not avalieble, leting the user know by an alert
    else {
        UIAlertController *pickerAlert = [UIAlertController alertControllerWithTitle:@"Erro" message:@"Modo de captura da imagem indisponível em seu dispositivo." preferredStyle:UIAlertControllerStyleAlert];
        [pickerAlert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:pickerAlert animated:YES completion:nil];
    }
}

- (IBAction)editImageButton:(id)sender {
    [self showCameraOrLibraryAllert];
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [self.viewModel saveStoreImage:info[UIImagePickerControllerOriginalImage]];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)callStore:(id)sender {
    [_viewModel callStore:^(NSString * _Nullable result, NSError * _Nullable error) {
        if(error == nil) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:result] options:@{} completionHandler:nil];
        } else {
            UIAlertController *pickerAlert = [UIAlertController alertControllerWithTitle:@"Erro" message:@"Aplicativo para ligações telefônicas indisponível em seu dispositivo." preferredStyle:UIAlertControllerStyleAlert];
            [pickerAlert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:pickerAlert animated:YES completion:nil];
        }
    }];
}

- (IBAction)directionsToStore:(id)sender {
    [_viewModel directionsToStore:^(NSMutableArray* result) {
        if (result.count == 0) {
            UIAlertController *pickerAlert = [UIAlertController alertControllerWithTitle:@"Erro" message:@"Apple Maps e Google Maps não disponíveis" preferredStyle:UIAlertControllerStyleAlert];
            [pickerAlert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:pickerAlert animated:YES completion:nil];
        } else {
            UIAlertController *pickerAlert = [UIAlertController alertControllerWithTitle:@"Escolha o app de navegação" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

            //Turning the alert compatible with iPad Apple standards
            UIPopoverPresentationController *popPresenter = [pickerAlert popoverPresentationController];
            popPresenter.sourceView = self.mapsButton;
            popPresenter.sourceRect = self.mapsButton.bounds;

            for (int i = 0; i < result.count; i++) {
                [pickerAlert addAction:[UIAlertAction actionWithTitle:result[i][0] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: result[i][1]] options:@{} completionHandler:nil];
                }]];
            }
            
            [pickerAlert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];
            [pickerAlert setModalPresentationStyle:UIModalPresentationPopover];
            
            //Presenting the alert
            [self presentViewController:pickerAlert animated:YES completion:nil];
        }
    }];
}

@end
