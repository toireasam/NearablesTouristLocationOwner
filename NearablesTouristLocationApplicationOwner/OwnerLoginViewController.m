//  OwnerLoginViewController.m

#import "OwnerLoginViewController.h"
#import "Parse/Parse.h"
#import "AdminUser.h"

@interface OwnerLoginViewController ()

@end

@implementation OwnerLoginViewController

@synthesize usernameTxt;
@synthesize passwordTxt;
@synthesize promptLblGeneral;
@synthesize loginBtn;
AdminUser *currentUser;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.promptLblGeneral.hidden = YES;
    
    // Tab the view to dismiss keyboard
    UITapGestureRecognizer *tapViewGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView)];
    [self.view addGestureRecognizer:tapViewGR];
    loginBtn.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didTapOnView {
    
    [self.usernameTxt resignFirstResponder];
    [self.passwordTxt resignFirstResponder];
}

- (IBAction)login:(id)sender {
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:self.usernameTxt.text
                                 password:self.passwordTxt.text
                                    block:^(PFUser *pfUser, NSError *error)
     {
         if (pfUser && !error) {
             
             weakSelf.promptLblGeneral.hidden = YES;
             
             // Check if the user is an admin
             NSString *userType = [[PFUser currentUser] objectForKey:@"UserType"];
             
             if([userType isEqual: @"Admin"])
             {
                 currentUser = [[AdminUser alloc]init];
                 currentUser.username = [[PFUser currentUser] objectForKey:@"username"];
                 [self setUsername:currentUser.username];
                 
                 currentUser.isLoggedIn = TRUE;
                 [self setUserLogin:@"in"];
                 
                 currentUser.adminsTouristLocation = [[PFUser currentUser] objectForKey:@"TouristLocationName"];
                 
                 [self setAdminLocation:currentUser.adminsTouristLocation];
                 
                 [self dismissViewControllerAnimated:YES completion:nil];
             }
             else
             {
                 // The login failed. Show error.
                 weakSelf.promptLblGeneral.textColor = [UIColor redColor];
                 weakSelf.promptLblGeneral.text = @"Invalid credentials";
                 weakSelf.promptLblGeneral.hidden = NO;
                 
             }
         }
         else {
             // The login failed. Show error.
             weakSelf.promptLblGeneral.textColor = [UIColor redColor];
             weakSelf.promptLblGeneral.text = [error userInfo][@"error"];
             weakSelf.promptLblGeneral.hidden = NO;
         }
     }];
    
}
- (IBAction)forgotPassword:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email Address"
                                                        message:@"Enter the email for your account:"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        
        UITextField *emailAddress = [alertView textFieldAtIndex:0];
        
        [PFUser requestPasswordResetForEmailInBackground: emailAddress.text];
        
        UIAlertView *alertViewSuccess = [[UIAlertView alloc] initWithTitle:@"Success! A reset email was sent to you" message:@""
                                                                  delegate:self
                                                         cancelButtonTitle:@"Ok"
                                                         otherButtonTitles:nil];
        [alertViewSuccess show];
    }
}

-(void)setUserLogin:(NSString *)loggedInStatus
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:loggedInStatus forKey:@"loggedin"];
}

-(void)setUsername:(NSString *)username
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:username forKey:@"username"];
}

-(void)setAdminLocation:(NSString *)location
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:location forKey:@"TouristLocationName"];
    [standardDefaults synchronize];
}

@end
