//
//  CameraAppViewController.h
//  CameraApp
//
//  Created by Aferdita Muriqi on 4/02/14.
//  Copyright (c) 2014 ADEV Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraAppViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)savePhoto:(id)sender;

@end
