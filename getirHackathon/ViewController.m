//
//  ViewController.m
//  getirHackathon
//
//  Created by Dogan Altinbas on 18/03/2017.
//  Copyright © 2017 Dogan Altinbas. All rights reserved.
//

#import "ViewController.h"
#import "Elements.h"
#import "ShapeViewController.h"


@interface ViewController (){

NSMutableArray *elementList;

}
@property (weak, nonatomic) IBOutlet UITextField *nameTxf;
@property (weak, nonatomic) IBOutlet UITextField *emailTxf;
@property (weak, nonatomic) IBOutlet UITextField *gsmTxf;
@property (weak, nonatomic) IBOutlet UIButton *queryButton;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *patternImage = [UIImage imageNamed:@"generalBg.png"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:patternImage];
    elementList = [NSMutableArray new];
    self.navigationItem.title = @"Getir Hackathon";
    
    [self.nameTxf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.emailTxf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.gsmTxf addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
}

-(void)dismissKeyboard{

    [self.nameTxf resignFirstResponder];
    [self.emailTxf resignFirstResponder];
    [self.gsmTxf resignFirstResponder];

}

-(void)textFieldDidChange:(UITextField*)textField{

    if([self validateEmail:self.emailTxf.text]){
    
        if([self.nameTxf.text length] > 0 && [self.gsmTxf.text length] == 11){
        
            [self.queryButton setEnabled:YES];
        }
        
        else
            [self.queryButton setEnabled:NO];
            
    }
    else
        [self.queryButton setEnabled:NO];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    
    NSString *trimmed = [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //neglecting whitespace string
    if([trimmed length] == 0){
    
        if([textField.text length] != 0){
        
            if(newLength == 0)
                return  YES;
            else
                return NO;
        
        }
        
        else{
        
            if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
            
                return NO;
            
            }
        
            return YES;
        }
    
    }
    
    if(textField == self.nameTxf){
            return newLength > 20 ? NO:YES;
    }
    
    else if(textField == self.gsmTxf)
        return newLength > 11 ? NO:YES;
    
    else if(textField == self.emailTxf)
        return newLength > 30 ? NO:YES;
    
    return YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) validateEmail: (NSString*) validateEmail{

    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES[c] %@", emailRegex];
    
    return [emailTest evaluateWithObject:validateEmail];
    
}

- (IBAction)queryButton:(UIButton *)sender {
    
    [self callWebService];
}

-(void)callWebService{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *parameters = @{@"email": @"dogan", @"name": @"adsad", @"gsm":@"05396046901"};
    [manager POST:@"https://getir-bitaksi-hackathon.herokuapp.com/getElements" parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        for (NSDictionary *elementItem in responseObject[@"elements"]) {
            Elements *element = [[Elements alloc] initWithDictionary:elementItem];
            [elementList addObject:element];
        }
        
        [self performSegueWithIdentifier:@"toSendShapeSeg" sender:nil];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if([segue.identifier isEqualToString:@"toSendShapeSeg" ]){
        
        ShapeViewController *shapeVC = (ShapeViewController*) segue.destinationViewController;
        shapeVC.elementArray = elementList;
        elementList = [NSMutableArray new];

    }
    
}

@end
