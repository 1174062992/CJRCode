//
//  CJViewController.m
//  CJRCode
//
//  Created by 曹记 on 2018/2/6.
//  Copyright © 2018年 曹记. All rights reserved.
//

#import "CJViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "QRCodeGenerateVC.h"
#import "SGQRCodeScanningVC.h"
@interface CJViewController ()
@property(nonatomic,strong)UIImageView* BackImageView;
@end

@implementation CJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"二维码";
    self.view.backgroundColor = [UIColor whiteColor];
    self.BackImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.BackImageView.image =[UIImage imageNamed:@"bg_image"];
    [self.view addSubview:self.BackImageView];
    [self CreatUi];
}
-(void)CreatUi{
    //生成二维码
    self.BackImageView.userInteractionEnabled =YES;
    UIButton* CreatButton =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, 150, 150, 45)];
    [self.BackImageView addSubview:CreatButton];
    [CreatButton setTitle:@"生成二维码" forState:UIControlStateNormal];
    [CreatButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [CreatButton addTarget:self action:@selector(generateQRCode:) forControlEvents:UIControlEventTouchUpInside];
    CreatButton.backgroundColor =[UIColor orangeColor];
    //扫描二维码
    UIButton* ScanButton =[[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-75, 250, 150, 45)];
    [self.BackImageView addSubview:ScanButton];
    [ScanButton setTitle:@"扫描二维码" forState:UIControlStateNormal];
    [ScanButton addTarget:self action:@selector(scanningQRCode:) forControlEvents:UIControlEventTouchUpInside];
    [ScanButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    ScanButton.backgroundColor =[UIColor orangeColor];
}

/** 生成二维码方法 */
-(void)generateQRCode:(UIButton*)sender {
    QRCodeGenerateVC *VC = [[QRCodeGenerateVC alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

/** 扫描二维码方法 */
-(void)scanningQRCode:(id)sender {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    // 用户第一次同意了访问相机权限
                    NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);

                } else {
                    // 用户第一次拒绝了访问相机权限
                    NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            SGQRCodeScanningVC *vc = [[SGQRCodeScanningVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

            }];

            [alertC addAction:alertA];
            [self presentViewController:alertC animated:YES completion:nil];

        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {

        }];

        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
