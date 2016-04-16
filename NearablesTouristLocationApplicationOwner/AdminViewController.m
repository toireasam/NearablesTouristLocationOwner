//
//  AdminViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 19/03/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "AdminViewController.h"
#import "Parse/Parse.h"
#import "Global.h"

@interface AdminViewController ()

@end

@implementation AdminViewController
@synthesize galleryBtn;
@synthesize touristLocationName;

NSArray *pickerData;
NSString *insideLocationArtefactName;
NSString *artefactObjectID;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setHidesBackButton:YES];
    
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    touristLocationName = [standardDefaults stringForKey:@"TouristLocationName"];
    
    _categoryPicker.dataSource = self;
    _categoryPicker.delegate = self;
    
    [self getLocationArtefacts];
    
}

-(void)getLocationArtefacts
{
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    [query whereKey:@"TouristLocation" equalTo:touristLocationName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            if(objects.count == 0)
            {
                // No beacons were found
                
            }
            for (PFObject *object in objects)
            {
                artefactObjectID = object.objectId;
                insideLocationArtefactName = object [@"InsideTouristLocationArtefact"];
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

- (IBAction)buttonClickUpdateInfo:(id)sender {
    
    NSData *imageData = UIImageJPEGRepresentation(_ivPickedImage.image, 0.5);
    PFFile *imageFile;
    if(imageData != NULL)
    {
        imageFile = [PFFile fileWithName:@"LocationImage.png" data:imageData];
    }
    PFQuery *query = [PFQuery queryWithClassName:@"TouristLocations"];
    // Retrieve the object by id and update info
    [query getObjectInBackgroundWithId:artefactObjectID
                                 block:^(PFObject *object, NSError *error) {
                                     
                                     if(_touristLocationInfoEdit.text.length > 0)
                                     {
                                         object[@"Information"] = _touristLocationInfoEdit.text;
                                         [object saveInBackground];
                                         
                                     }
                                     
                                 }];
    
    if(imageFile != NULL)
    {
        PFObject *touristLocationImageClass = [PFObject objectWithClassName:@"InsideTouristLocation"];
        touristLocationImageClass[@"InsideTouristLocationArtefact"] = insideLocationArtefactName;
        touristLocationImageClass[@"TouristLocation"] = touristLocationName;
        touristLocationImageClass[@"ArtefactImage"] = imageFile;
        [touristLocationImageClass saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(succeeded){
                // object saved
            }
            else
            {
                // there was a problem
            }
        }];
        
    }
}

- (IBAction)btnGalleryClicked:(id)sender {
    
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

- (IBAction)btnCameraClicked:(id)sender {
    
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
    artefactObjectID = object.objectId;
    insideLocationArtefactName = object[@"InsideTouristLocationArtefact"];
    return object[@"InsideTouristLocationArtefact"];
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    PFObject *object = pickerData[row];
    insideLocationArtefactName = object[@"InsideTouristLocationArtefact"];
    artefactObjectID = object.objectId;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_touristLocationInfoEdit resignFirstResponder];
}

@end
