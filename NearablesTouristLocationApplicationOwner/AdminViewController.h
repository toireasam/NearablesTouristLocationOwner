//
//  AdminViewController.h
//  NearablesTouristLocationApplicationOwner
//
//  Created by Toireasa Moley on 21/03/2016.
//  Copyright © 2016 Toireasa Moley. All rights reserved.
//

#import "ViewController.h"

@interface AdminViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet UITextField *touristLocationInfoEdit;
@property (weak, nonatomic) IBOutlet UIButton *updateInfo;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;
@property (weak, nonatomic) IBOutlet UIButton *galleryBtn;
@property (nonatomic, strong) NSString *touristLocationName;
@property (weak, nonatomic) IBOutlet UIButton *picBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;


@end
