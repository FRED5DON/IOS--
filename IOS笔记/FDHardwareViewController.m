//
//  FDGCDCenterViewController.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-7-5.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "FDHardwareViewController.h"
#import "Func.h"
//#import <MessageUI/MFMessageComposeViewController.h>

#define _CAMERA_TAG 10
#define _DATA_TRANSITION_TAG 41
#define _ENV_TAG 42
@interface FDHardwareViewController()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
//MFMessageComposeViewControllerDelegate
@property(nonatomic,strong) Func *func;
@property(nonatomic,strong)NSDictionary *dict;
@property(nonatomic,strong)UITextView *tv;
@property(nonatomic,strong)UIButton *bt;
@property(nonatomic,strong)UIImageView *ivPhoto;
@end
@implementation FDHardwareViewController

-(void)transferData:(id)data
{
    if ([data isKindOfClass:[Func class]]) {
        self.func=(Func*)data;
    }
}


-(NSDictionary *)dict
{
    if (_dict==nil) {
        NSDictionary *dict=@{
                             @"4101":@"相机+图库调用",@"4102":@"电话+讯息服务"
                             ,@"4103":@"地图+位置",@"4104":@"感应器",
                             @"4105":@"获取环境信息"
                             ,@"4106":@"音量、屏幕亮度调节"
                             };

        _dict=dict;
    }
    return _dict;
}



-(void)viewDidLoad
{
    [super viewDidLoad];
    if (self.func!=nil) {
        self.navigationItem.title=self.func.name;
    }
    self.view.backgroundColor=[UIColor whiteColor];
    static int margin=10;
    int w=[UIScreen mainScreen].bounds.size.width-2*margin ;
    static int h=44;
    CGRect lastRect;
//    for (int i=0; i<self.dict.count; i++) {
        UIButton *button=[UIButton  buttonWithType:UIButtonTypeCustom];
//        button.titleLabel.text=self.dict[[NSString stringWithFormat:@"%d",self.func.idCode ]];
    [button setTitle:self.dict[[NSString stringWithFormat:@"%d",self.func.idCode ]]forState:UIControlStateNormal];
    button.backgroundColor=[UIColor orangeColor];
    button.titleLabel.tintColor=[UIColor redColor];
    button.titleLabel.textColor=[UIColor whiteColor];
        lastRect=CGRectMake(margin, 80, w, h);
        button.frame=lastRect;
    
    
        [self.view addSubview:button];
//        [button setTag:i];
        [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    _bt=button;
//    }
    _tv=[[UITextView alloc]initWithFrame:CGRectMake(margin, margin+CGRectGetMaxY(lastRect), CGRectGetWidth(lastRect),[UIScreen mainScreen].bounds.size.height-CGRectGetMaxY(lastRect)-margin)];
    [_tv setEditable:NO];
    [self.view addSubview:_tv];
}

-(void) btnClicked
{
    int tag=self.func.idCode;
    if (tag==4101) {
        [self takePicture];
    }
    else if (tag==4102) {
        [self wirelessService];
    }
    else if (tag==4103) {
       
    }
    else if (tag==4104) {
        
    }
    else if (tag==4105) {
         [self envInformation];
    }
    else if (tag==4106) {
        
    }
}

#pragma 相机、图库选择器

-(void)takePicture
{
    UIActionSheet *boSheet;
    //是否支持拍照
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        boSheet=[[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }else{
        boSheet=[[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    boSheet.tag=_CAMERA_TAG;
    [boSheet dismissWithClickedButtonIndex:0 animated:YES];
    [boSheet showInView:self.view];
}




//****UIActionSheet 代理方法
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag==_CAMERA_TAG) {
        //是否支持拍照
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            if (buttonIndex==0) {
                return;
            }
            else if (buttonIndex==1) {
                [self gotoCameraOrPhotosWithType:UIImagePickerControllerSourceTypeCamera];
            }
            else if (buttonIndex==2) {
                [self gotoCameraOrPhotosWithType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
            
        }else{
            if (buttonIndex==0) {
                return;
            }
            else if (buttonIndex==1) {
                [self gotoCameraOrPhotosWithType:UIImagePickerControllerSourceTypePhotoLibrary];
            }
            
        }
    }
    else if(actionSheet.tag==_DATA_TRANSITION_TAG)
    {
        if (buttonIndex==0) {
            return;
        }
        else if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
        }
        else if (buttonIndex==2) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://10086"]];
        }
        else if (buttonIndex==3) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://fabyuxuan@163.com"]];
        }
        else if (buttonIndex==3) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://3gqq.qq.com/"]];
        }
    }
    else if(actionSheet.tag==_ENV_TAG)
    {
        if (buttonIndex==0) {
            return;
        }
        else if (buttonIndex==1) {
            NSDate *  senddate=[NSDate date];
            
            NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
            
            [dateformatter setDateFormat:@"YYYY-MM-dd"];
            
            NSString *  locationString=[dateformatter stringFromDate:senddate];
            
            [self alert:locationString];
        }
        else if (buttonIndex==2) {
            NSMutableString *result=[NSMutableString string];
            //手机序列号
           // NSString* identifierNumber = [[UIDevice currentDevice] identifierNumber];
            NSLog(@"手机序列号: %@",@"【IOS8 需要权限】");
            //手机别名： 用户定义的名称
            NSString* userPhoneName = [[UIDevice currentDevice] name];
            NSLog(@"手机别名: %@", userPhoneName);
            [result appendFormat:@"手机别名: %@", userPhoneName];
            //设备名称
            NSString* deviceName = [[UIDevice currentDevice] systemName];
            [result appendFormat:@"设备名称: %@",deviceName ];
            //手机系统版本
            NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
            [result appendFormat:@"手机系统版本: %@", phoneVersion];
            //手机型号
            NSString* phoneModel = [[UIDevice currentDevice] model];
            [result appendFormat:@"手机型号: %@",phoneModel ];
            //地方型号  （国际化区域名称）
            NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
            [result appendFormat:@"国际化区域名称: %@",localPhoneModel ];
            
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // 当前应用名称
            NSString *appCurName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            [result appendFormat:@"当前应用名称：%@",appCurName];
            // 当前应用软件版本  比如：1.0.1
            NSString *appCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            [result appendFormat:@"当前应用软件版本:%@",appCurVersion];
            // 当前应用版本号码   int类型  
            NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];  
            [result appendFormat:@"当前应用版本号码：%@",appCurVersionNum];
            [self alert:result];
        }
        else if (buttonIndex==3) {
            
        }
        
    }
    
}



-(void)gotoCameraOrPhotosWithType:(NSUInteger) type
{
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = NO;
    
    imagePickerController.sourceType = type;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
        
    }];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    // 保存图片至本地
    if(_ivPhoto==nil){
        
        self.ivPhoto=[[UIImageView alloc]initWithImage:image];
        UIView *v=self.view.subviews[0];
        self.ivPhoto.frame=CGRectMake(0, CGRectGetMaxY(v.frame)+10, self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(v.frame)-10);
        [self.view addSubview:self.ivPhoto];
    }else{
        self.ivPhoto.image=image;
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma end 结束


#pragma 电话短信 服务

-(void)wirelessService
{
    UIActionSheet *boSheet;
    boSheet=[[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"电话",@"短信",@"邮件",@"safari", nil];
    boSheet.tag=_DATA_TRANSITION_TAG;
    [boSheet dismissWithClickedButtonIndex:0 animated:YES];
    [boSheet showInView:self.view];
}

#pragma 电话短信 服务

-(void)envInformation
{
    UIActionSheet *boSheet;
    boSheet=[[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"获取系统时间",@"获取系统版本",@"获取存储空间" , nil];
    boSheet.tag=_ENV_TAG;
    [boSheet dismissWithClickedButtonIndex:0 animated:YES];
    [boSheet showInView:self.view];
}





#pragma mark - end

-(void) alert:(NSString *)msg
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}
@end
