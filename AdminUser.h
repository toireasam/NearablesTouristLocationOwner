//  AdminUser.h

#import <Foundation/Foundation.h>

@interface AdminUser : NSObject

@property (weak,nonatomic) NSString *username;
@property (weak,nonatomic) NSString *adminsTouristLocation;
@property (assign) BOOL isLoggedIn;

@end

