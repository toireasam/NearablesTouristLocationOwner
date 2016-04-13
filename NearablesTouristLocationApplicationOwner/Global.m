//
//  Global.m
//  NearablesTouristLocationApplicationOwner
//
//  Created by Toireasa Moley on 13/04/2016.
//  Copyright © 2016 Toireasa Moley. All rights reserved.
//

#import "Global.h"



//DataClass.h



//DataClass.m
@implementation Global
@synthesize str;

static Global *instance = nil;

+(Global *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [Global new];
        }
    }
    return instance;
}

@end    
