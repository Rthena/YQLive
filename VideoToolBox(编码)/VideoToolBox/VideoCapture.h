//
//  VideoCapture.h
//  VideoToolBox
//
//  Created by Rthena on 2016/11/3.
//  Copyright © 2016年 Athena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoCapture : NSObject

- (void)startCapture:(UIView *)preview;

- (void)stopCapture;

@end
