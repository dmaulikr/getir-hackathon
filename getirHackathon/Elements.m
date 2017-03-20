//
//  Elements.m
//
//  Created by   on 28/02/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "Elements.h"


NSString *const kElementsHeight = @"height";
NSString *const kElementsXPosition = @"xPosition";
NSString *const kElementsColor = @"color";
NSString *const kElementsWidth = @"width";
NSString *const kElementsR = @"r";
NSString *const kElementsType = @"type";
NSString *const kElementsYPosition = @"yPosition";


@interface Elements ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Elements

@synthesize height = _height;
@synthesize xPosition = _xPosition;
@synthesize color = _color;
@synthesize width = _width;
@synthesize r = _r;
@synthesize type = _type;
@synthesize yPosition = _yPosition;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if (self && [dict isKindOfClass:[NSDictionary class]]) {
            self.height = [[self objectOrNilForKey:kElementsHeight fromDictionary:dict] doubleValue];
            self.xPosition = [[self objectOrNilForKey:kElementsXPosition fromDictionary:dict] doubleValue];
            self.color = [self objectOrNilForKey:kElementsColor fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kElementsWidth fromDictionary:dict] doubleValue];
            self.r = [[self objectOrNilForKey:kElementsR fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kElementsType fromDictionary:dict];
            self.yPosition = [[self objectOrNilForKey:kElementsYPosition fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kElementsHeight];
    [mutableDict setValue:[NSNumber numberWithDouble:self.xPosition] forKey:kElementsXPosition];
    [mutableDict setValue:self.color forKey:kElementsColor];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kElementsWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.r] forKey:kElementsR];
    [mutableDict setValue:self.type forKey:kElementsType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.yPosition] forKey:kElementsYPosition];

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

    self.height = [aDecoder decodeDoubleForKey:kElementsHeight];
    self.xPosition = [aDecoder decodeDoubleForKey:kElementsXPosition];
    self.color = [aDecoder decodeObjectForKey:kElementsColor];
    self.width = [aDecoder decodeDoubleForKey:kElementsWidth];
    self.r = [aDecoder decodeDoubleForKey:kElementsR];
    self.type = [aDecoder decodeObjectForKey:kElementsType];
    self.yPosition = [aDecoder decodeDoubleForKey:kElementsYPosition];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_height forKey:kElementsHeight];
    [aCoder encodeDouble:_xPosition forKey:kElementsXPosition];
    [aCoder encodeObject:_color forKey:kElementsColor];
    [aCoder encodeDouble:_width forKey:kElementsWidth];
    [aCoder encodeDouble:_r forKey:kElementsR];
    [aCoder encodeObject:_type forKey:kElementsType];
    [aCoder encodeDouble:_yPosition forKey:kElementsYPosition];
}

- (id)copyWithZone:(NSZone *)zone {
    Elements *copy = [[Elements alloc] init];
    
    
    
    if (copy) {

        copy.height = self.height;
        copy.xPosition = self.xPosition;
        copy.color = [self.color copyWithZone:zone];
        copy.width = self.width;
        copy.r = self.r;
        copy.type = [self.type copyWithZone:zone];
        copy.yPosition = self.yPosition;
    }
    
    return copy;
}


@end
