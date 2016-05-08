//  SettingsViewController.m

#import "SettingsViewController.h"
#import "OwnerLoginViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize logout;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    logout.userInteractionEnabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {
    
    [self setUserDefaults];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OwnerLoginViewController *viewController = (OwnerLoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"loginScreen"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:NO completion:nil];
}

-(void)setUserDefaults
{
    NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
    [standardDefaults setObject:@"out" forKey:@"loggedin"];
}

@end
