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
#import <Spotify/Spotify.h> 

#define kClientId "e6695c6d22214e0f832006889566df9c"

@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (nonatomic, strong) Song *currentSong;

- (void)handleNewSession:(SPTSession *)session;

@end

