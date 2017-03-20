//
//  BaseClass.m
//
//  Created by   on 28/02/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "BaseClass.h"
#import "Elements.h"


NSString *const kBaseClassCode = @"code";
NSString *const kBaseClassMsg = @"msg";
NSString *const kBaseClassInviteCode = @"inviteCode";
NSString *const kBaseClassElements = @"elements";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize code = _code;
@synthesize msg = _msg;
@synthesize inviteCode = _inviteCode;
@synthesize elements = _elements;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.code = [[self objectOrNilForKey:kBaseClassCode fromDictionary:dict] doubleValue];
            self.msg = [self objectOrNilForKey:kBaseClassMsg fromDictionary:dict];
            self.inviteCode = [self objectOrNilForKey:kBaseClassInviteCode fromDictionary:dict];
    NSObject *receivedElements = [dict objectForKey:kBaseClassElements];
    NSMutableArray *parsedElements = [NSMutableArray array];
    
    if ([receivedElements isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedElements) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedElements addObject:[Elements modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedElements isKindOfClass:[NSDictionary class]]) {
       [parsedElements addObject:[Elements modelObjectWithDictionary:(NSDictionary *)receivedElements]];
    }

    self.elements = [NSArray arrayWithArray:parsedElements];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kBaseClassCode];
    [mutableDict setValue:self.msg forKey:kBaseClassMsg];
    [mutableDict setValue:self.inviteCode forKey:kBaseClassInviteCode];
    NSMutableArray *tempArrayForElements = [NSMutableArray array];
    
    for (NSObject *subArrayObject in self.elements) {
        if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForElements addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForElements addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForElements] forKey:kBaseClassElements];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self.code = [aDecoder decodeDoubleForKey:kBaseClassCode];
    self.msg = [aDecoder decodeObjectForKey:kBaseClassMsg];
    self.inviteCode = [aDecoder decodeObjectForKey:kBaseClassInviteCode];
    self.elements = [aDecoder decodeObjectForKey:kBaseClassElements];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_code forKey:kBaseClassCode];
    [aCoder encodeObject:_msg forKey:kBaseClassMsg];
    [aCoder encodeObject:_inviteCode forKey:kBaseClassInviteCode];
    [aCoder encodeObject:_elements forKey:kBaseClassElements];
}

- (id)copyWithZone:(NSZone *)zone {
    BaseClass *copy = [[BaseClass alloc] init];
    
    
    
    if (copy) {

        copy.code = self.code;
        copy.msg = [self.msg copyWithZone:zone];
        copy.inviteCode = [self.inviteCode copyWithZone:zone];
        copy.elements = [self.elements copyWithZone:zone];
    }
    
    return copy;
}


@end
