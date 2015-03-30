//
//  JNKeychain.m
//
//  Created by Jeremias Nunez on 5/10/13.
//  Copyright (c) 2013 Jeremias Nunez. All rights reserved.
//
//  jeremias.np@gmail.com

#define CHECK_OSSTATUS_ERROR(x) (x == noErr) ? YES : NO

#import "JNKeychain.h"

static NSMutableString *__accessGroup = nil;

@interface JNKeychain ()

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)key;

@end

@implementation JNKeychain

#pragma mark - Private
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)key
{
    // see http://developer.apple.com/library/ios/#DOCUMENTATION/Security/Reference/keychainservices/Reference/reference.html
    NSMutableDictionary *query = [@{(__bridge id)kSecClass            : (__bridge id)kSecClassGenericPassword,
              (__bridge id)kSecAttrService      : key,
              (__bridge id)kSecAttrAccount      : key,
              (__bridge id)kSecAttrAccessible   : (__bridge id)kSecAttrAccessibleAfterFirstUnlock
              } mutableCopy];
    if ([__accessGroup length] > 0) {
        query[(__bridge id)(kSecAttrAccessGroup)] = __accessGroup;
    }
    return query;
}

#pragma mark - Public

+ (void)setAccessGroup:(NSString *)accessGroup {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __accessGroup = [[NSMutableString alloc] init];
    });
    if (accessGroup == nil) {
        [__accessGroup setString:@""];
    } else {
        [__accessGroup setString:accessGroup];
    }
}

+ (BOOL)saveValue:(id)value forKey:(NSString*)key
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    // delete any previous value with this key (we could use SecItemUpdate but its unnecesarily more complicated)
    [self deleteValueForKey:key];
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:(__bridge id)kSecValueData];
    
    OSStatus result = SecItemAdd((__bridge CFDictionaryRef)keychainQuery, NULL);
    return CHECK_OSSTATUS_ERROR(result);
}

+ (BOOL)deleteValueForKey:(NSString *)key
{
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    
    OSStatus result = SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
    return CHECK_OSSTATUS_ERROR(result);
}

+ (id)loadValueForKey:(NSString *)key
{
    id value = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:key];
    CFDataRef keyData = NULL;
    
    [keychainQuery setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    [keychainQuery setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            value = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        }
        @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", key, e);
            value = nil;
        }
        @finally {}
    }
    
    if (keyData) {
        CFRelease(keyData);
    }
    
    return value;
}

@end
