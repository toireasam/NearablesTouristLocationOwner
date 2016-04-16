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
@synthesize usernameTxtField;
@synthesize passwordTxtField;
@synthesize promptLbl;

NSString *adminsTouristLocation;


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

- (IBAction)login:(id)sender {
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:self.usernameTxtField.text
                                 password:self.passwordTxtField.text
                                    block:^(PFUser *pfUser, NSError *error)
     {
         if (pfUser && !error) {
             
             weakSelf.promptLbl.hidden = YES;
             
             // check if admin
             NSString *userType = [[PFUser currentUser] objectForKey:@"UserType"];
             adminsTouristLocation = [[PFUser currentUser] objectForKey:@"TouristLocationName"];

             if([userType isEqual: @"Admin"])
             {
                 NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
                 [standardDefaults setObject:@"in" forKey:@"loggedin"];

                 [standardDefaults setObject:adminsTouristLocation forKey:@"TouristLocationName"];
                 [standardDefaults synchronize];
                
                 [self dismissViewControllerAnimated:YES completion:nil];                 
                 
             }
             else
             {
                     // The login failed. Show error.
                     weakSelf.promptLbl.textColor = [UIColor redColor];
                     weakSelf.promptLbl.text = @"Incorrect credentials";
                     weakSelf.promptLbl.hidden = NO;
             
             }
         }
             else {
             // The login failed. Show error.
             weakSelf.promptLbl.textColor = [UIColor redColor];
             weakSelf.promptLbl.text = [error userInfo][@"error"];
             weakSelf.promptLbl.hidden = NO;
         }
     }];
     
}

@end
