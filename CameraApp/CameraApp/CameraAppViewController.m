//
//  CameraAppViewController.m
//  CameraApp
//
//  Created by Aferdita Muriqi on 4/02/14.
//  Copyright (c) 2014 ADEV Inc. All rights reserved.
//

#import "CameraAppViewController.h"

@import MediaPlayer;
@import MobileCoreServices;
@import AssetsLibrary;

@interface CameraAppViewController ()

@end

@implementation CameraAppViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Checking to make sure there is a camera to use.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)takePhoto:(id)sender {
    
    // Instantiating and presenting camera interface
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    // Setting the CameraAppVC as the picker delegate
    picker.delegate = self;
    
    // camera interface and user interaction handled by the system
    
    /*
     Have to set media types.  Set mediaTypes property to an array containing still image type
     first call availableMediaTypesForSourceType: class method to find out which media types are available
     do an if statment to save the still image type to an array
     call the mediaTypes method with the array with only still images
     or apparently the default value is image only?
     [picker mediaTypes:@[@"kUTTypeImage"]];
     For stills only
     */
    
    
    // picker allows editing
    picker.allowsEditing = YES;
    
    // setting the source type as the camera rather than the media browser
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)savePhoto:(id)sender {
    
   // UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    

    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    [library writeImageDataToSavedPhotosAlbum:UIImagePNGRepresentation(self.imageView.image) metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        
        
        if(error) {
            NSLog(@"CameraViewController: Error on saving movie : %@ {imagePickerController}", error);
        }
        else {
            NSLog(@"URL: %@", assetURL);
        }
        
    }];

}





- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != nil) {
        NSLog(@"Couldn't save image");
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Couldn't save image"
                                                              message:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
        
    } else {
        NSLog(@"Saved image");
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Saved image"
                                                              message:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
        
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.imageView.image = chosenImage;

    }
    else
    {
        UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
        self.imageView.image = chosenImage;
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
