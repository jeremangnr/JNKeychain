//
//  JNKeychain.h
//
//  Created by Jeremias Nunez on 5/10/13.
//  Copyright (c) 2013 Jeremias Nunez. All rights reserved.
//
//  Based on Anomie's great answer - http://stackoverflow.com/a/5251820
//
//  jeremias.np@gmail.com

#import <Foundation/Foundation.h>

@interface JNKeychain : NSObject

+ (void)saveValue:(id)data forKey:(NSString*)key;
+ (id)loadValueForKey:(NSString*)key;
+ (void)deleteValueForKey:(NSString *)key;

@end
