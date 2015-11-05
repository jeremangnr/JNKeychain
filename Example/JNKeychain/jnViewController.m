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
    
    NSString *accessGroup = @"org.cocoapods.demo.JNKeychain";
    
    NSString *bundleSeedId = [self bundleSeedID];
    NSString *keychainSharingAccessGroup = [NSString stringWithFormat:@"%@.%@", [self bundleSeedID], accessGroup];

    NSLog(@"Bundle Seed ID = %@", bundleSeedId);
    NSLog(@"Keychain Sharing Access Group = %@", keychainSharingAccessGroup);
    
    NSLog(@"Running generic Keychain test");
    [self testKeychain:@"genericTestValue" forKey:@"genericTestKey" andAccessGroup:nil];
    
    NSLog(@"Running Keychain test with access group sharing");
    [self testKeychain:@"accessGroupTestValue" forKey:@"accessGroupTestKey" andAccessGroup:keychainSharingAccessGroup];
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

- (NSString *)bundleSeedID
{
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge NSString *)kSecClassGenericPassword, (__bridge NSString *)kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge NSString *)kSecAttrAccessGroup];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

@end
