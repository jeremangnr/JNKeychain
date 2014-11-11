//
//  jnViewController.m
//  JNKeychain
//
//  Created by Jeremias Nunez on 11/11/2014.
//  Copyright (c) 2014 Jeremias Nunez. All rights reserved.
//

#import "jnViewController.h"
#import <JNKeychain/JNKeychain.h>

@interface jnViewController ()

@end

@implementation jnViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSString *testKey = @"myTestKey";
    NSString *testValue = @"myTestValue";

    if ([JNKeychain saveValue:testValue forKey:testKey]) {
        NSLog(@"Correctly saved value '%@' for key '%@'", testValue, testKey);
    } else {
        NSLog(@"Failed to save!");
    }
    
    NSLog(@"Value for key '%@' is: '%@'", testKey, [JNKeychain loadValueForKey:testKey]);
    
    if ([JNKeychain deleteValueForKey:testKey]) {
        NSLog(@"Deleted value for key '%@'. Value is: %@", testKey, [JNKeychain loadValueForKey:testKey]);
    } else {
        NSLog(@"Failed to delete!");
    }
}

@end
