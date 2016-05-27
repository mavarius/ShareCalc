//
//  MSCFlipSegue.m
//  ShareCalc
//
//  Created by Daniel Campbell on 4/27/16.
//  Copyright © 2016 Daniel Campbell. All rights reserved.
//

#import "MSCFlipSegue.h"
#import <QuartzCore/QuartzCore.h>

NSString *MSCFlipToSell = @"MSCFlipToSell";
NSString *MSCFlipToBuy = @"MSCFlipToSell";


@interface UIView (contents)

-(UIImage *)mscImageContents;

@end


@implementation UIView (contents)

-(UIImage *)mscImageContents {
    CGSize mySize = [self bounds].size;
    UIGraphicsBeginImageContextWithOptions(mySize, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end


@interface MSCFlipSegue ()

@property(nonatomic, strong) CALayer *overlay;

@end


@implementation MSCFlipSegue

@synthesize overlay = _overlay;

#pragma mark - Init

-(id)initWithIdentifier:(NSString *)identifier
                 source:(UIViewController *)source
            destination:(UIViewController *)destination
{
    // initialize view controller & overlay layer
    if (self = [super initWithIdentifier:identifier source:source destination:destination]) {
        UINavigationController *navController = source.navigationController;
        
        CGRect bounds = navController.view.bounds;
        
        CALayer *overlayLayer = [CALayer layer];
        overlayLayer.frame = bounds;
        _overlay = overlayLayer;
    }
    
    return self;
}

-(void)perform {
    UIViewController *source = self.sourceViewController;
    UIViewController *destination = self.destinationViewController;
    
    UINavigationController *navController = source.navigationController;
    
    // Use image of old view in overlay layer
    UIImage *sourceImage = [navController.view mscImageContents];
    self.overlay.contents = (id)sourceImage.CGImage;
    
    // Push view to stack
    if ([self.identifier isEqualToString:MSCFlipToBuy]) {
        // From Buy (initial) to sell, pop old view
        [navController popViewControllerAnimated:NO];
    } else {
        [navController pushViewController:destination animated:NO];
    }
    
    // Get new view to transition to
    UIImage *destImage = [navController.view mscImageContents];
    
    // Create image layers
    self.overlay.anchorPoint = CGPointMake(0.5, 0.5);
    self.overlay.doubleSided = NO;
    self.overlay.zPosition = 150;
    
    CGImageRef backImage = CGImageCreateCopy(destImage.CGImage);
    CALayer *backLayer = [CALayer layer];
    backLayer.frame = navController.view.bounds;
    backLayer.contents = (__bridge id)backImage;
    CGImageRelease(backImage);
    backLayer.anchorPoint = CGPointMake(0.5, 0.5);
    backLayer.doubleSided = NO;
    backLayer.zPosition = 150;
    
    // Add layers
    
    CALayer *backgroundLayer = [[CALayer alloc] init];
    [backgroundLayer setFrame:navController.view.bounds];
    [backgroundLayer setBackgroundColor:[UIColor darkGrayColor].CGColor];
    [backgroundLayer setZPosition:1];
    
    [navController.view.layer addSublayer:backgroundLayer];
    [navController.view.layer addSublayer:self.overlay];
    [navController.view.layer addSublayer:backLayer];
    
    // Perspective Transform
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = -1.0f / 850.0f;
    [navController.view.layer setSublayerTransform:perspectiveTransform];
    
    CGFloat flipDuration = 1.0f;
    NSString *animName = @"segue";
    
    // Upon Completion
    [CATransaction setCompletionBlock:^{
        [self.overlay removeAllAnimations];
        [self.overlay removeFromSuperlayer];
        self.overlay = nil;
        
        [backLayer removeAllAnimations];
        [backLayer removeFromSuperlayer];
        
        [backgroundLayer removeFromSuperlayer];
        navController.view.userInteractionEnabled = YES;
    }];
    
    // Animation
    navController.view.userInteractionEnabled = NO;
    [CATransaction begin];
    {
        [CATransaction setAnimationDuration:flipDuration];
        {
            CABasicAnimation *frontFlip = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
            frontFlip.duration = flipDuration;
            frontFlip.fromValue = @0;
            frontFlip.toValue = @M_PI;
            frontFlip.removedOnCompletion = NO;
            frontFlip.autoreverses = NO;
            frontFlip.fillMode = @"forwards";
            [self.overlay addAnimation:frontFlip forKey:animName];
            
            CABasicAnimation *backFlip = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
            backFlip.duration = flipDuration;
            backFlip.fromValue = @M_PI;
            backFlip.toValue = @(2*M_PI);
            backFlip.removedOnCompletion = NO;
            backFlip.autoreverses = NO;
            backFlip.fillMode = @"forwards";
            [backLayer addAnimation:backFlip forKey:animName];
            
            CAKeyframeAnimation *scale = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            scale.duration = flipDuration;
            scale.values = @[@0.83, @0.70, @0.83];
            scale.removedOnCompletion = NO;
            scale.autoreverses = NO;
            scale.fillMode = @"forwards";
            [backLayer addAnimation:scale forKey:@"scaleOut"];
            [self.overlay addAnimation:scale forKey:@"scaleOut"];
        }
    }
    [CATransaction commit];
    
}

@end
