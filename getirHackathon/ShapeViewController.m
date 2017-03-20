//
//  ShapeViewController.m
//  getirHackathon
//
//  Created by Dogan Altinbas on 20/03/2017.
//  Copyright © 2017 Dogan Altinbas. All rights reserved.
//

#import "ShapeViewController.h"

@interface ShapeViewController ()

@end

@implementation ShapeViewController
UIScrollView* scrollView;
int maxWidth = 0;
int maxHeight = 0;

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *patternImage = [UIImage imageNamed:@"generalBg.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    self.navigationItem.title = @"Şekiller";
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.scrollEnabled = YES;
    //scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2, self.view.bounds.size.height);
    [self.view addSubview:scrollView];

    for (int i = 0; i < [self.elementArray count]; i ++) {
        if([[self.elementArray[i] valueForKey:@"type"] isEqualToString:@"circle"])
            [self drawCircle:i];
        else if([[self.elementArray[i] valueForKey:@"type"] isEqualToString:@"rectangle"])
            [self drawRectangle:i];
    }
    
    
    // Do any additional setup after loading the view.
}

-(void)drawRectangle:(int)index{

    NSNumber *xPosition = [[self.elementArray objectAtIndex:index] valueForKey:@"xPosition"];
    NSNumber *yPosition = [[self.elementArray objectAtIndex:index] valueForKey:@"yPosition"];
    NSNumber *width     = [[self.elementArray objectAtIndex:index] valueForKey:@"width"];
    NSNumber *height    = [[self.elementArray objectAtIndex:index] valueForKey:@"height"];
    NSString *hexColor  = [NSString stringWithFormat:@"#%@",[[self.elementArray objectAtIndex:index] valueForKey:@"color"]];

    UIView *rectView  = [[UIView alloc] initWithFrame:CGRectMake([xPosition intValue], [yPosition intValue], [width intValue], [height intValue])];
    rectView.backgroundColor = [self colorWithHexString:hexColor alpha:1];
    [self updateScrollViewContentSize:rectView.frame.size.width + rectView.frame.origin.x heightSize:rectView.frame.size.height + rectView.frame.origin.y];
    [scrollView addSubview:rectView];
    
}

-(void)drawCircle:(int)index{
    
    NSNumber *xPosition = [[self.elementArray objectAtIndex:index] valueForKey:@"xPosition"];
    NSNumber *yPosition = [[self.elementArray objectAtIndex:index] valueForKey:@"yPosition"];
    NSNumber *r         = [[self.elementArray objectAtIndex:index] valueForKey:@"r"];
    
    NSString *hexColor  = [NSString stringWithFormat:@"#%@",[[self.elementArray objectAtIndex:index] valueForKey:@"color"]];
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    [circleLayer setPath:[[UIBezierPath bezierPathWithOvalInRect:CGRectMake([xPosition intValue], [yPosition intValue], 2* [r intValue], 2* [r intValue])] CGPath]];
    [circleLayer setBackgroundColor:[[self colorWithHexString:hexColor alpha:1] CGColor]];
    [self updateScrollViewContentSize:circleLayer.frame.size.width + circleLayer.frame.origin.x heightSize:circleLayer.frame.size.height + circleLayer.frame.origin.y];
    [[scrollView layer] addSublayer:circleLayer];
}

- (UIColor *)colorWithHexString:(NSString *)str_HEX  alpha:(CGFloat)alpha_range{
    int red = 0;
    int green = 0;
    int blue = 0;
    sscanf([str_HEX UTF8String], "#%02X%02X%02X", &red, &green, &blue);
    return  [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha_range];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Updating scrollView according to shapes' coordinates
-(void)updateScrollViewContentSize:(int)width heightSize:(int)height{
    
    if(maxWidth < width)
        maxWidth = width;
    if(maxHeight < height)
        maxHeight = height;
    
    scrollView.contentSize = CGSizeMake(maxWidth*1.2, maxHeight*1.2);

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
