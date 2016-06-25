//
//  ViewController.h
//  ExampleOfgoogleMaps
//
//  Created by Sethu on 24/06/16.
//  Copyright © 2016 kaizen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ViewController : UIViewController

@property(strong, nonatomic)GMSAutocompleteResultsViewController * resultsViewController;
@property(strong,nonatomic)UISearchDisplayController * searchController;
@property(strong,nonatomic)UISearchBar * searchBar;
@property(strong, nonatomic)GMSAutocompleteTableDataSource * tableviewdelegate;

@end

