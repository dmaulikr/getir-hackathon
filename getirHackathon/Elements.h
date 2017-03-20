//
//  Elements.h
//
//  Created by   on 28/02/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Elements : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double height;
@property (nonatomic, assign) double xPosition;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double r;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) double yPosition;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
