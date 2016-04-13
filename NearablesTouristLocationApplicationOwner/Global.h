//
//  Global.h
//  NearablesTouristLocationApplicationOwner
//
//  Created by Toireasa Moley on 13/04/2016.
//  Copyright © 2016 Toireasa Moley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Global : NSObject {
    
    NSString *str;
}

@property(nonatomic,retain)NSString *str;
+(Global*)getInstance;
@end