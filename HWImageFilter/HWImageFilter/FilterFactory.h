//
//  FilterFactory.h
//  HWImageFilter
//
//  Created by Михаил Асмаковец on 25.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface FilterFactory : NSObject
- (UIImage *)sepiaTone: (UIImage *) imageToFilter withIntensity: (NSNumber *) intensity;

- (UIImage *) sharpenLuminance: (UIImage *) imageToFilter inputRadius: (NSNumber *) radius inputSharpness: (NSNumber *) sharpness;

- (UIImage *) gaussianBlur: (UIImage *) imageToFilter inputRadius: (NSNumber *) radius;
@end

NS_ASSUME_NONNULL_END
