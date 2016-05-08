//  AdminUser.h

#import <Foundation/Foundation.h>

@interface AdminUser : NSObject

@property (weak,nonatomic) NSString *username;
@property (weak,nonatomic) NSString *adminsTouristLocation;
@property (weak,nonatomic) NSString *email;
@property (weak,nonatomic) NSString *userType;
@property (assign) BOOL isLoggedIn;

@end

