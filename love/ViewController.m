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

@property (strong, nonatomic) IBOutlet UIImageView *albumCover;
@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UILabel *currentTime;
@property (strong, nonatomic) IBOutlet UILabel *endTime;
@property (strong, nonatomic) IBOutlet UILabel *song;
@property (strong, nonatomic) IBOutlet UILabel *artist;

@property (strong, nonatomic) NSString *address;

@end

//test to push

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLocation];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - Location
- (void) setUpLocation {
 
    self.manager = [CLLocationManager new];
    self.manager.delegate = self;
    [self.manager requestWhenInUseAuthorization];
    
    //change the desired specifity of the location
    self.manager.desiredAccuracy = kCLLocationAccuracyBest;
    
    //calling method below
    [self startLocation];
}

//TODO - call this method!
- (void)startLocation {
    [self.manager startUpdatingLocation];
}


/*
 threee different methods
*/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    NSLog(@"hit");
    [self.manager stopUpdatingLocation];
    
    CLLocation *newLocation = [locations objectAtIndex:locations.count - 1];

    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    //Geocoding Block
    
    [geocoder reverseGeocodeLocation: newLocation completionHandler: ^(NSArray *placemarks, NSError *error) {
        
         CLPlacemark *placemark = [placemarks objectAtIndex:0];

         //String to hold address
        NSString *city = placemark.locality;
        NSString *state = placemark.administrativeArea;
        self.address = [[NSString alloc]initWithFormat:@"%@_%@", city, state];
        
         //Print the location to console
        NSLog(@"I am currently at %@",self.address);
     }];
}

#pragma mark - Getting From the Server (JSON)
- (void)fetchFeedWith:(NSString *)inputURL {
    
    __weak ViewController *weakSelf = self;
    
    NSURL *URL = [NSURL URLWithString:inputURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest: request queue: [NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse* response, NSData* data, NSError* connectionError){
         NSLog(@"data is kinda here");
         //the same as calling self, but its a safety to make sure self hasn't been set to nil
         //since this is inside of a 'block'
         [weakSelf extractData:data];
     }];
}

- (void) extractData: (NSData*) someData  {
    
    NSArray *song = [NSJSONSerialization JSONObjectWithData:someData options:0 error:nil];
    NSLog(@"The data is downloaded");
    
}


#pragma mark - Interacting with the music


#pragma mark - memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
