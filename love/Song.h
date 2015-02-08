//
//  Song.h
//  love
//
//  Created by Jordan White on 2/8/15.
//  Copyright (c) 2015 Two Beards and Fro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

@property (strong, nonatomic) NSString *songId;
@property int startAt;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *artist;

//may not need
@property int que;


@end
