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


@property (weak, nonatomic) IBOutlet UIButton *playStop;
@property BOOL playing;

@end

//test to push

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpLocation];
    
    //initialize the current song
    self.currentSong = [[Song alloc]init];
    _playing = YES;
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
    
    //TODO
    //call the fetchFeed, not sure if this should be done?
    NSString *url = [[NSString alloc]initWithFormat:@"http://104.236.79.116:8000/api"];
    [self fetchFeedWith:url];
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

- (void) extractData: (NSData*)data  {
    
    //NSArray *songArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //adds information to the currentSong
    self.currentSong.songId = [[NSString alloc]initWithFormat:@"%@", [dict objectForKey:@"SongId"]];
    NSLog(@"ID: %@", self.currentSong.songId);
}


#pragma mark - Interacting with the music
- (IBAction)playStop:(UIButton *)sender {
    
    if (_playing == YES) {
        //stop music &
        //set it to the play icon
        UIImage *stop = [UIImage imageNamed:@"play.png"];
        [self.playStop setImage:stop forState:UIControlStateNormal];
        _playing = NO;
    }
    else {
        //start music
        //set it to the stop icon
        UIImage *play = [UIImage imageNamed:@"stop.png"];
        [self.playStop setImage:play forState: UIControlStateNormal];
        _playing = YES;
    }
}



#pragma mark - memory warning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
