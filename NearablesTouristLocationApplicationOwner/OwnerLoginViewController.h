//  OwnerLoginViewController.h

#import "ViewController.h"

@interface OwnerLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UILabel *promptLblGeneral;
@property (weak, nonatomic) IBOutlet UITextField *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end
