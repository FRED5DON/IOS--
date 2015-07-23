//
//  SecondViewController.m
//  IOS笔记
//
//  Created by MacBook On Dell on 15-6-28.
//  Copyright (c) 2015年 Fred.Don. All rights reserved.
//

#import "SecondViewController.h"
#define _CAMERA_TAG 1001;

@interface SecondViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btCamera=[UIButton buttonWithType:UIButtonTypeContactAdd];
    btCamera.frame=CGRectMake(20, 80, 60, 69);
    [self.view addSubview:btCamera];
    
    [btCamera addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
}

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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int tag=_CAMERA_TAG;
    if (actionSheet.tag==tag) {
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
    
}

-(void)gotoCameraOrPhotosWithType:(NSUInteger) type
{
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
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

    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
