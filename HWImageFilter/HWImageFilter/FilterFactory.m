//
//  FilterFactory.m
//  HWImageFilter
//
//  Created by Михаил Асмаковец on 25.11.2019.
//  Copyright © 2019 Михаил Асмаковец. All rights reserved.
//

#import "FilterFactory.h"

@implementation FilterFactory

- (UIImage *)imageAfterFiltering:(UIImage *)imageToFilter withIntensity: (NSNumber *) intensity
{
    UIImage *imageToDisplay = [self normalizedImageWithImage:imageToFilter];
    
    CIContext *context = [[CIContext alloc] initWithOptions:nil];
    CIImage *ciImage = [[CIImage alloc] initWithImage:imageToDisplay];
    
    CIFilter *ciEdges = [CIFilter filterWithName:@"CISepiaTone"];
    [ciEdges setValue:ciImage forKey:kCIInputImageKey];
    [ciEdges setValue:intensity forKey:@"inputIntensity"];
    CIImage *result = [ciEdges valueForKey:kCIOutputImageKey];
    
    CGRect extent = [result extent];
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];
    UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
    CFRelease(cgImage);
    
    return filteredImage;
}

- (UIImage *)normalizedImageWithImage:(UIImage *)image
{
    if (image.imageOrientation == UIImageOrientationUp)
    {
        return image;
    }
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    [image drawInRect:(CGRect){0, 0, image.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

@end
