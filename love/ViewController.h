//
//  ViewController.h
//  love
//
//  Created by Jordan White on 2/7/15.
//  Copyright (c) 2015 Two Beards and Fro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Song.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) Song *currentSong;

@end

