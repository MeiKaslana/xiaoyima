//
//  CalendarViewController.m
//  xiaoyima
//
//  Created by qdazzle on 2022/2/28.
//

#import <Foundation/Foundation.h>
#import "LoginViewController.h"
#import <objc/runtime.h>


#define kAdaptW(floatValue) ({\
    float tmp = 0.0f;\
    if (UIDevice.currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {\
        tmp = floatValue * 1.5;\
    } else {\
        tmp = floatValue*[[UIScreen mainScreen] bounds].size.width/375.0;\
    }\
    tmp;\
})

#ifdef DEBUG
#define NSLog(format,...) printf("\n[%s] %s [第%d行] %s\n",__TIME__,__FUNCTION__,__LINE__,[[NSString stringWithFormat:format,## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *AccountInput;

@property (weak, nonatomic) IBOutlet UITextField *PasswordInput;
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;



@end
IB_DESIGNABLE
@implementation LoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_PasswordInput resignFirstResponder];
    [_AccountInput resignFirstResponder];
}
- (IBAction)LoginOnClick:(id)sender {
    //后面再加判断
    [self dismissModalViewControllerAnimated:YES];
}



//圆角
- (void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    _RegisterButton.layer.cornerRadius  = _cornerRadius;
    _RegisterButton.layer.masksToBounds = YES;
}

- (void)setBcolor:(UIColor *)bcolor{
    _bcolor = bcolor;
    _RegisterButton.layer.borderColor = _bcolor.CGColor;
}

- (void)setBwidth:(CGFloat)bwidth {
    _bwidth = bwidth;
    _RegisterButton.layer.borderWidth = _bwidth;
}
@end
