//
//  ViewController.m
//  ExampleOfgoogleMaps
//
//  Created by Sethu on 24/06/16.
//  Copyright © 2016 kaizen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<GMSAutocompleteTableDataSourceDelegate,GMSAutocompleteResultsViewControllerDelegate,UISearchDisplayDelegate>

{
    GMSMarker *london ;
}
@end

@implementation ViewController
{
     GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self
//                                                     selector:@selector(checkAlert) userInfo:nil repeats:YES];
//    [self PloyLines];
    [self current_location];
    [self Adding_Image_To_Location];
    [self kerala_LatandLong];
    [self searchBar_controller];
    
   }
-(void)current_location
{
    // Do any additional setup after loading the view, typically from a nib.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:13.0827
                                                            longitude:80.2707
                                                                 zoom:5];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.snippet = @"Chennai";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView_;
    
    mapView_.settings.compassButton = YES;
    mapView_.settings.myLocationButton = YES;
    self.view = mapView_;
    mapView_.myLocationEnabled = YES;


}


-(void)Adding_Image_To_Location
{

    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(19.0760, 72.8777);
    GMSMarker * london1 = [GMSMarker markerWithPosition:position];
    london1.title = @"Mumbai";
    london1.snippet = @"Population: 8,174,100";

    london1.icon = [UIImage imageNamed:@"location_icon.png"];
    london1.appearAnimation = kGMSMarkerAnimationPop;
    london1.map = mapView_;
    

   
    
}

-(void)kerala_LatandLong
{
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(10.8505, 76.2711);
//    CLLocationDegrees degrees = 45;
    london.tracksInfoWindowChanges = YES;

    london = [GMSMarker markerWithPosition:position];
    london.groundAnchor = CGPointMake(0.5, 0.5);
//    london.rotation = degrees;
    london.title = @"Kerala";
    london.flat = YES;
//    london.icon = [UIImage imageNamed:@"location_icon.png"];
    london.map = mapView_;
}

-(void)rotate_marker
{
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(10.8505, 76.2711);
    CLLocationDegrees degrees = 45;
    GMSMarker *london2 = [GMSMarker markerWithPosition:position];
    london2.groundAnchor = CGPointMake(0.5, 0.5);
    london2.rotation = degrees;
    london2.map = mapView_;
}

-(void)checkAlert
{
    NSLog(@"hai");
}
-(void)PloyLines
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
                                                            longitude:-165
                                                                 zoom:2];
    GMSMapView * mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
//    GMSStrokeStyle *solidBlue = [GMSStrokeStyle solidColor:[UIColor blueColor]];
//    GMSStyleSpan *solidBlueSpan = [GMSStyleSpan spanWithStyle:solidBlue];
//    GMSStrokeStyle *redYellow = [GMSStrokeStyle gradientFromColor:[UIColor redColor] toColor:[UIColor yellowColor]];
//    GMSStyleSpan *redYellowSpan = [GMSStyleSpan spanWithStyle:redYellow];

    GMSMutablePath *path = [GMSMutablePath path];
    [path addLatitude:-33.866 longitude:151.195]; //Sydney
    [path addLatitude:-18.142 longitude:178.431]; // Fiji
    [path addLatitude:21.291 longitude:-157.821]; // Hawaii
    [path addLatitude:37.423 longitude:-122.091]; // Mountain View
    
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor greenColor];
    
    polyline.strokeWidth = 5.f;
    polyline.map = mapView;
    
    self.view = mapView;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar_controller
{
//    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 250.0f, 44.0f)];
//
//    _resultsViewController = [[GMSAutocompleteResultsViewController alloc] init];
//    _resultsViewController.delegate = self;
//    
//    _searchController = [[UISearchController alloc]
//                         initWithSearchResultsController:_resultsViewController];
//    _searchController.searchResultsUpdater = _resultsViewController;
//    
//    UIView *subView = [[UIView alloc] initWithFrame:CGRectMake(0, 65.0, 414, 50)];
//    
//    [subView addSubview:_searchController.searchBar];
//    [_searchController.searchBar sizeToFit];
//    [self.view addSubview:subView];
//    
//    // When UISearchController presents the results view, present it in
//    // this view controller, not one further up the chain.
//    self.definesPresentationContext = YES;
    
    
    
    
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 250.0f, 44.0f)];
    
    _tableviewdelegate = [[GMSAutocompleteTableDataSource alloc] init];
    _tableviewdelegate.delegate = self;
    
    _searchController = [[UISearchDisplayController alloc] initWithSearchBar:_searchBar
                                                                 contentsController:self];
    _searchController.searchResultsDataSource = _tableviewdelegate;
    _searchController.searchResultsDelegate = _tableviewdelegate;
    _searchController.delegate = self;
    
    [self.view addSubview:_searchBar];
    
}

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
 didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
}

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
