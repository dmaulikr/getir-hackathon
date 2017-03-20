//
//  BaseClass.h
//
//  Created by   on 28/02/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double code;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *inviteCode;
@property (nonatomic, strong) NSArray *elements;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
