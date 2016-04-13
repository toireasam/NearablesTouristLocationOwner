//
//  LoginViewController.m
//  NearablesTouristLocationApplication
//
//  Created by Toireasa Moley on 07/03/2016.
//  Copyright © 2016 Estimote. All rights reserved.
//

#import "OwnerLoginViewController.h"

#import "AdminViewController.h"
#import "Parse/Parse.h"
#import "Global.h"


@interface OwnerLoginViewController ()

@end

@implementation OwnerLoginViewController
NSString *touristLocationAdmin;
@synthesize usernameTxtField;
@synthesize passwordTxtField;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.promptLbl.hidden = YES;
    // Tab the view to dismiss keyboard
    UITapGestureRecognizer *tapViewGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView)];
    [self.view addGestureRecognizer:tapViewGR];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapOnView {
    [self.usernameTxtField resignFirstResponder];
    [self.passwordTxtField resignFirstResponder];
}

- (IBAction)signup:(id)sender {
    PFUser *pfUser = [PFUser user];
    pfUser.username = self.usernameTxtField.text;
    pfUser.password = self.passwordTxtField.text;
    
    __weak typeof(self) weakSelf = self;
    [pfUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            weakSelf.promptLbl.textColor = [UIColor greenColor];
            weakSelf.promptLbl.text = @"Signup successful!";
            weakSelf.promptLbl.hidden = NO;
        } else {
            weakSelf.promptLbl.textColor = [UIColor redColor];
            weakSelf.promptLbl.text = [error userInfo][@"error"];
            weakSelf.promptLbl.hidden = NO;
        }
    }];
}

- (IBAction)login:(id)sender {
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:self.usernameTxtField.text
                                 password:self.passwordTxtField.text
                                    block:^(PFUser *pfUser, NSError *error)
     {
         if (pfUser && !error) {
             // Proceed to next screen after successful login.
             
             weakSelf.promptLbl.hidden = YES;
             
             // check if admin
             NSString *athleteId = [[PFUser currentUser] objectForKey:@"Admin"];
             // get the location admin is associated with
             touristLocationAdmin = [[PFUser currentUser] objectForKey:@"TouristLocationName"];
             
             //NSLog(@"The athlete id is %@", athleteId);
             NSLog(athleteId);
             
             
             if([athleteId isEqual: @"yes"])
             {
                 NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
                 [standardDefaults setObject:@"in" forKey:@"loggedin"];

                 
                 NSLog(@"The athlete id is %@", athleteId);
                 // go to admin
                 NSLog(@"should move to admin screeen");
                 NSUserDefaults *standardDefaults2 = [NSUserDefaults standardUserDefaults];
                 [standardDefaults setObject:touristLocationAdmin forKey:@"TouristLocationName"];
                 [standardDefaults synchronize];
              [self dismissViewControllerAnimated:YES completion:nil];
                 NSLog(touristLocationAdmin);
                 
                 
             }
             else
             {
                 // they are a customer
                 NSLog(@"The athlete id is %@", athleteId);
                 
                 // go to customer
                 NSLog(@"should move to customer screeen");
                 //[weakSelf performSegueWithIdentifier:@"test" sender:self];
                 [self performSegueWithIdentifier:@"test" sender:self];
                 
           
             
             }}
             else {
             // The login failed. Show error.
             weakSelf.promptLbl.textColor = [UIColor redColor];
             weakSelf.promptLbl.text = [error userInfo][@"error"];
             weakSelf.promptLbl.hidden = NO;
         }
     }];
     
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"admin"]) {
        AdminViewController *nextVC = (AdminViewController *)[segue destinationViewController];
        
        
        NSLog(@"tourist location admin is");
        NSLog(touristLocationAdmin);
        nextVC.touristLocationNameTxt = touristLocationAdmin;
       nextVC.touristLocationNameEdit = touristLocationAdmin;
        
    }
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
