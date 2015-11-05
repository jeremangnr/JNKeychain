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
    
    // The Keychain Access Group defined under Keychain Sharing Capabilities and in the corresponding Entitlements file
    NSString *accessGroup = @"demo.JNKeychain.shared";
    
    NSLog(@"Running generic Keychain test");
    [self testKeychain:@"genericTestValue" forKey:@"genericTestKey" andAccessGroup:nil];
    
    NSLog(@"Running Keychain test with access group sharing");
    [self testKeychain:@"accessGroupTestValue" forKey:@"accessGroupTestKey" andAccessGroup:accessGroup];
}

- (void)testKeychain:(NSString *)value forKey:(NSString *)key andAccessGroup:(NSString *)group
{
    NSString *forGroupLog = (group ? [NSString stringWithFormat:@" for access group '%@'", group] : @"");
                          
    if ([JNKeychain saveValue:value forKey:key forAccessGroup:group]) {
        NSLog(@"Correctly saved value '%@' for key '%@'%@", value, key, forGroupLog);
    } else {
        NSLog(@"Failed to save!%@", forGroupLog);
    }
    
    NSLog(@"Value for key '%@' is: '%@'%@", key, [JNKeychain loadValueForKey:key forAccessGroup:group], forGroupLog);
    
    if ([JNKeychain deleteValueForKey:key forAccessGroup:group]) {
        NSLog(@"Deleted value for key '%@'. Value is: '%@'%@", key, [JNKeychain loadValueForKey:key forAccessGroup:group], forGroupLog);
    } else {
        NSLog(@"Failed to delete!%@", forGroupLog);
    }
}

@end
