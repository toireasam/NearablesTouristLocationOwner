//
//  OwnerLoginViewController.h
//  NearablesTouristLocationApplicationOwner
//
//  Created by Toireasa Moley on 21/03/2016.
//  Copyright © 2016 Toireasa Moley. All rights reserved.
//

#import "ViewController.h"

@interface OwnerLoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameTxtField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;
@property (weak, nonatomic) IBOutlet UILabel *promptLbl;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end
