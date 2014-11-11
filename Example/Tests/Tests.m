//
//  JNKeychainTests.m
//  JNKeychainTests
//
//  Created by Jeremias Nunez on 11/11/2014.
//  Copyright (c) 2014 Jeremias Nunez. All rights reserved.
//

#import <JNKeychain/JNKeychain.h>

SpecBegin(InitialSpecs)

describe(@"basic tests", ^{
    NSString *testKey = @"myTestKey";
    NSString *testValue = @"myTestValue";
    
    it(@"can save values to the keychain", ^{
        BOOL result = [JNKeychain saveValue:testValue forKey:testKey];
        expect(result).to.equal(YES);
    });
    
    it(@"can load values from the keychain", ^{
        NSString *value = [JNKeychain loadValueForKey:testKey];
        expect(value).to.equal(testValue);
    });
    
    it(@"can remove values from the keychain", ^{
        BOOL result = [JNKeychain deleteValueForKey:testKey];
        expect(result).to.equal(YES);
    });
});

SpecEnd
