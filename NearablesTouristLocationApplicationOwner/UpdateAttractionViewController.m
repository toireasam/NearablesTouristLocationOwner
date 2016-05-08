//  UpdateAttractionViewController.m

#import "UpdateAttractionViewController.h"
#import "Parse/Parse.h"
#import "TouristLocation.h"
#import "TouristLocationArtefact.h"

@interface UpdateAttractionViewController ()

@end

@implementation UpdateAttractionViewController

@synthesize galleryBtn;
@synthesize update;
@synthesize gallery;
@synthesize camera;
NSArray *pickerData;
TouristLocation *touristLocation;
TouristLocationArtefact *touristLocationArtefact;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    
    touristLocation = [[TouristLocation alloc]init];
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    touristLocation.touristLocationName = [standardDefaults stringForKey:@"TouristLocationName"];
    
    _categoryPicker.dataSource = self;
    _categoryPicker.delegate = self;
    
    [self getLocationBeacons];
    camera.userInteractionEnabled = NO;
    gallery.userInteractionEnabled = NO;
    update.userInteractionEnabled = NO;
}

-(void)getLocationBeacons
{
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"TouristLocation" equalTo:touristLocation.touristLocationName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            if(objects.count == 0)
            {
                // No beacons were found
                
            }
            for (PFObject *object in objects)
            {
                touristLocationArtefact = [[TouristLocationArtefact alloc]init];
                touristLocationArtefact.artefactID = object.objectId;
                touristLocationArtefact.artefactName = object [@"InsideTouristLocationArtefact"];
            }
            
            pickerData = objects;
            [self.categoryPicker reloadAllComponents];
        }
        else
        {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)updateTouristLocationInformation:(id)sender {
    
    PFFile *imageFile;
    
    CGRect rect = CGRectMake(0,0,200,200);
    UIGraphicsBeginImageContext( rect.size );
    [_ivPickedImage.image drawInRect:rect];
    UIImage *resizeForParse = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageData = UIImagePNGRepresentation(resizeForParse);
    UIImage *img=[UIImage imageWithData:imageData];
    
    if(img != NULL)
    {
        imageFile = [PFFile fileWithName:@"LocationImage.png" data:imageData];
    }
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    // Retrieve the object by id and update info
    [query getObjectInBackgroundWithId:touristLocationArtefact.artefactID
                                 block:^(PFObject *object, NSError *error) {
                                     
                                     if(_touristLocationInfoTxt.text.length > 0)
                                     {
                                         object[@"Information"] = _touristLocationInfoTxt.text;
                                         [object saveInBackground];
                                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                                                         message:@"Your attraction information was successfully updated."
                                                                                        delegate:nil
                                                                               cancelButtonTitle:@"OK"
                                                                               otherButtonTitles:nil];
                                         [alert show];
                                         
                                     }
                                     else
                                     {
                                         // User just wants to upload image
                                     }
                                     
                                 }];
    
    if(imageFile != NULL)
    {
        PFObject *touristLocationImageClass = [PFObject objectWithClassName:@"InsideTouristLocation"];
        touristLocationImageClass[@"InsideTouristLocationArtefact"] = touristLocationArtefact.artefactName;
        touristLocationImageClass[@"TouristLocation"] = touristLocation.touristLocationName;
        touristLocationImageClass[@"ArtefactImage"] = imageFile;
        [touristLocationImageClass saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded)
            {
                // Image is saved
            }
            else
            {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}

- (IBAction)openGallery:(id)sender {
    
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:galleryBtn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}

- (IBAction)openCamera:(id)sender {
    
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No Camera Available." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    _ivPickedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    PFObject *object = pickerData[row];
    touristLocationArtefact.artefactID = object.objectId;
    touristLocationArtefact.artefactName = object[@"InsideTouristLocationArtefact"];
    return object[@"InsideTouristLocationArtefact"];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    PFObject *object = pickerData[row];
    touristLocationArtefact.artefactName = object[@"InsideTouristLocationArtefact"];
    touristLocationArtefact.artefactID = object.objectId;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_touristLocationInfoTxt resignFirstResponder];
}

@end
