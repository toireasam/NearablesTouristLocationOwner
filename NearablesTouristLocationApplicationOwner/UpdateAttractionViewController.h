//  UpdateAttractionViewController.h

#import "ViewController.h"

@interface UpdateAttractionViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet UITextField *touristLocationInfoTxt;
@property (weak, nonatomic) IBOutlet UIButton *updateInfoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;
@property (weak, nonatomic) IBOutlet UIButton *galleryBtn;
@property (weak, nonatomic) IBOutlet UIPickerView *categoryPicker;
@property (weak, nonatomic) IBOutlet UITextField *camera;
@property (weak, nonatomic) IBOutlet UITextField *gallery;
@property (weak, nonatomic) IBOutlet UIButton *cameraBtn;
@property (weak, nonatomic) IBOutlet UITextField *update;

@end
