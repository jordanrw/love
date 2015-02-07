//
//  ViewController.m
//  love
//
//  Created by Jordan White on 2/7/15.
//  Copyright (c) 2015 Two Beards and Fro. All rights reserved.
//

#import "ViewController.h"

//@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>


@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *manager;
@property (weak, nonatomic) IBOutlet UILabel *longLabel;
@property (weak, nonatomic) IBOutlet UILabel *latLabel;


@end

//test to push

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLocation];
}


- (void) setUpLocation {
 
    self.manager = [CLLocationManager new];
    self.manager.delegate = self;
    [self.manager requestWhenInUseAuthorization];
    
    //change the desired specifity of the location
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    //self.manager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
}


- (void)startLocation {
    [self.manager startUpdatingLocation];
}


- (IBAction)click:(UIButton *)sender {
    [self startLocation];
    
}


/*
 threee different methods
*/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"hit");
    [self.manager stopUpdatingLocation];
    
    CLLocation *newLocation = [locations objectAtIndex:locations.count - 1];
    NSLog(@"%@", newLocation);
    
    NSString *longitude = [[NSString alloc]initWithFormat:@"%f", newLocation.coordinate.longitude];
    NSString *latitude = [[NSString alloc] initWithFormat:@"%f", newLocation.coordinate.latitude];

    
    [self.longLabel setText:longitude];
    [self.latLabel setText:latitude];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    NSLog(@"hit2");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
