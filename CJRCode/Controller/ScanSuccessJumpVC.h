//
//  CJViewController.m
//  CJRCode
//
//  Created by 曹记 on 2018/2/6.
//  Copyright © 2018年 曹记. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScanSuccessJumpVC : UIViewController

/** 接收扫描的二维码信息 */
@property (nonatomic, copy) NSString *jump_URL;
/** 接收扫描的条形码信息 */
@property (nonatomic, copy) NSString *jump_bar_code;

@end
